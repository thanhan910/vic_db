import time
import json
from tqdm import tqdm
from pymongo import MongoClient
from requests.exceptions import HTTPError
import requests
from bs4 import BeautifulSoup
import pandas as pd

from pyptvdata.apiv3 import PTVAPI3
from pyptvdata.gtfs import read_gtfs_zip

# import pandas as pd
# import folium
# import numpy as np
# import os
# import matplotlib as mpl
# import matplotlib.pyplot as plt
# import matplotlib.colors as mcolors
# from shapely.geometry import Polygon

SESSION = requests.Session()

MONGO_CLIENT = MongoClient('mongodb://localhost:27017/')
PTV_DB = MONGO_CLIENT['ptv']

ENV = json.load(open('../local-env.json'))
PTV_API_CLIENT = PTVAPI3(ENV['PTV_TIMETABLE_DEV_ID'], ENV['PTV_TIMETABLE_API_KEY'])


def get_all_directions():
    all_routes = PTV_API_CLIENT.get_all_routes()
    all_directions = []
    with tqdm(total=len(all_routes), desc="Getting directions for all routes") as pbar:
        for route in all_routes:
            route_id = route['route_id']
            while True:
                try:
                    directions = PTV_API_CLIENT.get_route_directions(route_id)['directions']
                    break
                except HTTPError as e:
                    if e.response.status_code == 403:
                        tqdm.write("Rate limit exceeded. Sleeping for 30 seconds...")
                        time.sleep(30)
                    else:
                        tqdm.write(f"Error getting directions for route {route_id}")
                        tqdm.write(e)
                    # pbar.set_postfix_str("Timeout. Sleeping for 30 seconds...")
                    # pbar.set_postfix_str(str(e))
                except Exception as e:
                    tqdm.write(e)
                    tqdm.write("Resetting the connection in 30 seconds...")
                    time.sleep(30)
                    continue
            all_directions.extend(directions)
            pbar.update(1)        
    return all_directions


def get_all_directions_stops(all_directions : list[str, dict]):
    all_direction_stops = []
    with tqdm(total=len(all_directions), desc="Getting stops for all directions") as pbar:
        for direction_obj in all_directions:
            route_id = direction_obj['route_id']
            route_type = direction_obj['route_type']
            direction_id = direction_obj['direction_id']
            while True:
                try:
                    stops = PTV_API_CLIENT.get_route_stops(
                        route_id, 
                        route_type, 
                        direction_id, 
                        include_geopath=True
                    )
                    break
                except HTTPError as e:
                    if e.response.status_code == 403:
                        tqdm.write("Rate limit exceeded. Sleeping for 30 seconds...")
                        time.sleep(30)
                    else:
                        tqdm.write(f"Error getting stops for route {route_id}, direction {direction_id}")
                        tqdm.write(e)
                    # pbar.set_postfix_str("Timeout. Sleeping for 30 seconds...")
                    # pbar.set_postfix_str(str(e))
                except Exception as e:
                    tqdm.write(e)
                    tqdm.write("Resetting the connection in 30 seconds...")
                    time.sleep(30)
                    continue
            direction_obj['stops'] = stops['stops']
            direction_obj['geopath'] = stops['geopath']

            direction_obj['_id'] = f"{route_id}.{route_type}.{direction_id}"
            
            # Insert one, remove if already exists
            # if PTV_DB['direction_stops'].find_one({'_id': direction_obj['_id']}):
            #     PTV_DB['direction_stops'].delete_one({'_id': direction_obj['_id']})

            all_direction_stops.append(direction_obj)

            pbar.update(1)

    return all_direction_stops

def get_all_stops_info(all_stops_idrt : list[tuple[int, int]], save_to_mongo=True):

    all_stops = []
    with tqdm(total=len(all_stops_idrt), desc="Getting stops information") as pbar:
        for stop_id, route_type in all_stops_idrt:    
            while True:
                try:
                    stop_info = PTV_API_CLIENT.get_stop_info(
                        stop_id = stop_id, 
                        route_type = route_type, 
                        gtfs = None,
                        stop_location = True,
                        stop_amenities = True,
                        stop_accessibility = True,
                        stop_contact = True,
                        stop_ticket = True,
                        stop_staffing = True,
                        stop_disruptions = True
                    )
                    break
                except HTTPError as e:
                    if e.response.status_code == 403:
                        tqdm.write("Rate limit exceeded. Sleeping for 30 seconds...")
                        time.sleep(30)
                    else:
                        tqdm.write(f"Stop {stop_id} at route type {route_type} not found")
                        stop_info = {
                            'stop_id': stop_id,
                            'route_type': route_type,
                            'error': str(e)
                        }
                        break
                except Exception as e:
                    tqdm.write(e)
                    tqdm.write("Resetting the connection in 30 seconds...")
                    time.sleep(30)
                    continue

            
            stop_info['_id'] = f"{stop_id}.{route_type}"
            
            all_stops.append(stop_info)

            if save_to_mongo:
                PTV_DB['stops'].insert_one(stop_info)

            pbar.update(1)
    
    return all_stops


class PTVWebDataClient:
    def __init__(self):
        self.token = BeautifulSoup(requests.get('https://www.ptv.vic.gov.au').content, 'html.parser').find(id='fetch-key').get('value')

    def get_data(self, endpoint, auth=True):
        if auth:
            if '?' not in endpoint:
                endpoint += '?' + '__tok=' + self.token
            else:
                endpoint += '&' + '__tok=' + self.token
        response = requests.get(f'https://www.ptv.vic.gov.au{endpoint}')
        response.raise_for_status()
        return response.json()


def complete_stops_info(all_directions_stops):
    """
    Complete the stops information with the information from the PTV website
    """

    PTV_WEB_CLIENT = PTVWebDataClient()

    # routes_all_web = PTV_WEB_CLIENT.get_data('/lithe/routes')
    stops_all_web = PTV_WEB_CLIENT.get_data('/lithe/stored-stops-all')

    stops_rt_web = [(int(stop['id']), int(stop['primaryChronosMode'])) for stop in stops_all_web['stops']]

    stops_rt_v3 = [(stop['stop_id'], stop['route_type']) for ds in all_directions_stops for stop in ds['stops']]

    print(len(set(stops_rt_web) - set(stops_rt_v3)), len(set(stops_rt_v3) - set(stops_rt_web)))

    odd_stops = list(set(stops_rt_web) - set(stops_rt_v3))

    new_stops = []

    with tqdm(total=len(odd_stops)) as pbar:
        for stop_id, route_type in odd_stops:
            while True:
                try:
                    data = PTV_WEB_CLIENT.get_data(f'/lithe/stop-services?stop_id={stop_id}&mode_id={route_type}')
                    break
                except HTTPError as e:
                    if e.response.status_code == 403:
                        tqdm.write("Website Timeout 30")
                        time.sleep(30)
                        continue
                    else:
                        tqdm.write('Website', stop_id, route_type, e.response.status_code)
                        break
            while True:
                try:
                    stop_info = PTV_API_CLIENT.get_stop_info(stop_id, route_type)
                    break
                except HTTPError as e:
                    if e.response.status_code == 403:
                        tqdm.write("API Timeout 30")
                        time.sleep(30)
                        continue
                    else:
                        stop_info = {
                            'stop_id': stop_id,
                            'route_type': route_type,
                            'error': str(e)
                        }
                        tqdm.write('API', stop_id, route_type, e.response.status_code)
                        break
                except Exception as e:
                    tqdm.write(e)
                    tqdm.write("Resetting the connection in 30 seconds...")
                    time.sleep(30)
                    continue
                
            stop_info['_id'] = f"{stop_id}.{route_type}"

            # Check if already exists
            if not PTV_DB['stops'].find_one({'_id': stop_info['_id']}):
                PTV_DB['stops'].insert_one(stop_info)
            else:
                obj = PTV_DB['stops'].find_one({'_id': stop_info['_id']})
                if 'error' in obj:
                    PTV_DB['stops'].delete_one({'_id': stop_info['_id']})
                    PTV_DB['stops'].insert_one(stop_info)
                else:
                    print('Already exists', stop_id, route_type)

            new_stops.append(stop_info)
            
            pbar.update(1)

    return new_stops


def get_more_gtfs_stops_info(gtfs_no_api_list, save_to_mongo=True):

    MODE_ID_ROUTE_TYPES = {
        '1': [3, 0, 1, 2],
        '2': [0, 3, 1, 2],
        '3': [1, 2, 3, 0],
        '4': [2, 3, 1, 0],
        '5': [3, 2, 1, 0],
        '6': [0, 1, 2, 3],
        '7': [2, 3, 1, 4],
        '8': [4, 2, 3, 1],
        '10': [0, 3, 1, 2],
        '11': [2, 3, 0, 1],
    }

    gtfs_sid_rt = []
    tqdm_count = 0
    for gtfs_stop in gtfs_no_api_list:
        gtfs_stop_id = gtfs_stop['stop_id']
        gtfs_mode_ids = gtfs_stop['mode_id']
        stop_route_types = set()
        for mode_id in gtfs_mode_ids:
            stop_route_types.update(MODE_ID_ROUTE_TYPES[mode_id])
        stop_route_types = list(stop_route_types)
        gtfs_sid_rt.append((gtfs_stop_id, stop_route_types))
        tqdm_count += len(stop_route_types)

    all_stops = []

    # with tqdm(total=len(all_stops_idrt), desc="Getting stops information") as pbar:
    with tqdm(total=tqdm_count) as pbar:
        for gtfs_stop_id, route_types in gtfs_sid_rt:
            for route_type in route_types:  
                _id_mongo = f"gtfs.{gtfs_stop_id}.{route_type}"
                if save_to_mongo:
                    stop_info = PTV_DB['stops'].find_one({'_id': _id_mongo})
                    if stop_info:
                        # stop_info = PTV_DB['stops'].find_one({'_id': _id_mongo})
                        # all_stops.append(stop_info)
                        pbar.update(1)
                        continue
                while True:
                    try:
                        stop_info = PTV_API_CLIENT.get_stop_info(
                            stop_id = gtfs_stop_id, 
                            route_type = route_type, 
                            gtfs = True,
                            stop_location = True,
                            stop_amenities = True,
                            stop_accessibility = True,
                            stop_contact = True,
                            stop_ticket = True,
                            stop_staffing = True,
                            stop_disruptions = True
                        )
                        break
                    except HTTPError as e:
                        if e.response.status_code == 403:
                            tqdm.write("Rate limit exceeded. Sleeping for 30 seconds...")
                            time.sleep(30)
                        else:
                            # print(f"Stop {gtfs_stop_id} at route type {route_type} not found")
                            stop_info = {
                                'gtfs_stop_id': gtfs_stop_id,
                                'route_type': route_type,
                                'error': str(e)
                            }
                            break
                    except Exception as e:
                        print(e)
                        print("Resetting the connection in 30 seconds...")
                        time.sleep(30)
                        continue
                        # pbar.set_postfix_str("Timeout. Sleeping for 30 seconds...")
                        # pbar.set_postfix_str(str(e))
                        # Print, but keep the progress bar running cleanly

                
                stop_info['_id'] = _id_mongo
                
                all_stops.append(stop_info)

                if save_to_mongo:
                    if not PTV_DB['stops'].find_one({'_id': stop_info['_id']}):
                        PTV_DB['stops'].insert_one(stop_info)
                    else:
                        obj = PTV_DB['stops'].find_one({'_id': stop_info['_id']})
                        if 'error' in obj:
                            PTV_DB['stops'].delete_one({'_id': stop_info['_id']})
                            PTV_DB['stops'].insert_one(stop_info)

                pbar.update(1)
        
    return all_stops

if __name__ == "__main__":

    # Collect all routes, directions and stops from PTV API
    PTV_DB['routes'].drop()

    all_routes = PTV_API_CLIENT.get_all_routes()
    for route in all_routes:
        route['_id'] = route['route_id']

    PTV_DB['routes'].insert_many(all_routes)


    # Get all directions and stops information of all routes
    all_directions = get_all_directions()
    all_directions_stops = get_all_directions_stops(all_directions)
    PTV_DB['directions_stops'].drop()
    PTV_DB['directions_stops'].insert_many(all_directions_stops)


    # Get all stops information
    all_stops_idrt = [(stop['stop_id'], stop['route_type']) for direction in all_directions_stops for stop in direction['stops']]
    all_stops_idrt = list(set(all_stops_idrt))
    PTV_DB['stops'].drop()
    all_stops = get_all_stops_info(all_stops_idrt, save_to_mongo=True)



    new_stops = complete_stops_info(all_directions_stops)


    # ----------------------------------------------------
    # Compare the collected stops from the API with the stops in the GTFS dataset, and get the information of GTFS stops with missing API information.
    # ----------------------------------------------------


    # 1min - 1min 30s
    GTFS_PTV = read_gtfs_zip()
    # 1min - 1min 30s

    # Assert that all stop_ids in stop_times are in stops
    for mode_id in GTFS_PTV:
        stop_times_ids = GTFS_PTV[mode_id]['stop_times']['stop_id'].unique()
        stops_ids = GTFS_PTV[mode_id]['stops']['stop_id'].unique()
        assert len(set(stop_times_ids) - set(stops_ids)) == 0, mode_id



    for mode_id in GTFS_PTV:
        GTFS_PTV[mode_id]['stops']['mode_id'] = mode_id
    gtfs_stops_df = pd.concat([GTFS_PTV[mode_id]['stops'] for mode_id in GTFS_PTV], ignore_index=True)
    gtfs_stops_uid_df = gtfs_stops_df.groupby('stop_id').agg({'stop_name': 'unique', 'stop_lat': 'unique', 'stop_lon': 'unique', 'mode_id': 'unique'}).reset_index()



    pipeline = [
        {
            '$match': {
                '$or': [
                    # {'_id': {'$regex': 'gtfs'}},
                    {'error': {'$exists': False}}
                ]
            }
        },
        {
            '$project': {
                '_id': 1,
                'api_point_id' : '$stop.point_id',
                'api_mode_id' : '$stop.mode_id',
                'api_stop_id' : '$stop.stop_id',
                'api_route_type' : '$stop.route_type',
                'api_latitude' : '$stop.stop_location.gps.latitude',
                'api_longitude' : '$stop.stop_location.gps.longitude',
                'api_stop_name' : '$stop.stop_name',
                'api_stop_name_primary' : '$stop.stop_location.primary_stop_name',
                'api_road_type_primary' : '$stop.stop_location.road_type_primary',
                'api_stop_name_second' : '$stop.stop_location.second_stop_name',
                'api_road_type_second' : '$stop.stop_location.road_type_second',
                'api_bay_nbr' : '$stop.stop_location.bay_nbr',
                'api_postcode' : '$stop.stop_location.postcode',
                'api_municipality' : '$stop.stop_location.municipality',
                'api_municipality_id' : '$stop.stop_location.municipality_id',
                'api_stop_landmark' : '$stop.stop_landmark',
                'api_suburb' : '$stop.stop_location.suburb',
            }
        }
    ]

    api_stops_list = list(PTV_DB['stops'].aggregate(pipeline))
    api_stops_df = pd.DataFrame(api_stops_list)

    api_stops_df['api_mode_id'] = api_stops_df['api_mode_id'].astype(str)
    api_stops_df['api_stop_id'] = api_stops_df['api_stop_id'].astype(str)

    api_stops_df['gtfs_stop_id'] = api_stops_df.apply(lambda x: x['_id'].split('.')[1] if 'gtfs.' in x['_id'] else str(int(x['api_point_id'])), axis=1)

    stops_uid_df = pd.merge(gtfs_stops_uid_df, api_stops_df, left_on='stop_id', right_on='gtfs_stop_id', how='outer', suffixes=('_gtfs', '_api'))


    gtfs_no_api_list = stops_uid_df[stops_uid_df['api_stop_id'].isna()][['stop_id', 'mode_id']].to_dict('records')


    all_stops = get_more_gtfs_stops_info(gtfs_no_api_list, save_to_mongo=True)