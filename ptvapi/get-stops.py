import time
import json
from tqdm import tqdm
from pymongo import MongoClient
from requests.exceptions import HTTPError
import requests
from bs4 import BeautifulSoup

from pyptvdata.apiv3 import PTVAPI3

# import pandas as pd
# import folium
# import numpy as np
# import os
# import matplotlib as mpl
# import matplotlib.pyplot as plt
# import matplotlib.colors as mcolors
# from shapely.geometry import Polygon

SESSION = requests.Session()

MONGO_CLIENT = MongoClient()
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
                        print("Rate limit exceeded. Sleeping for 30 seconds...")
                        time.sleep(30)
                    else:
                        print(f"Error getting directions for route {route_id}")
                        print(e)
                    # pbar.set_postfix_str("Timeout. Sleeping for 30 seconds...")
                    # pbar.set_postfix_str(str(e))
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
                        print("Rate limit exceeded. Sleeping for 30 seconds...")
                        time.sleep(30)
                    else:
                        print(f"Error getting stops for route {route_id}, direction {direction_id}")
                        print(e)
                    # pbar.set_postfix_str("Timeout. Sleeping for 30 seconds...")
                    # pbar.set_postfix_str(str(e))
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
                        print("Rate limit exceeded. Sleeping for 30 seconds...")
                        time.sleep(30)
                    else:
                        print(f"Stop {stop_id} at route type {route_type} not found")
                        stop_info = {
                            'stop_id': stop_id,
                            'route_type': route_type,
                            'error': str(e)
                        }
                        break
                    # pbar.set_postfix_str("Timeout. Sleeping for 30 seconds...")
                    # pbar.set_postfix_str(str(e))
                    # Print, but keep the progress bar running cleanly

            
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
                        print("Website Timeout 30")
                        time.sleep(30)
                        continue
                    else:
                        print('Website', stop_id, route_type, e.response.status_code)
                        break
            while True:
                try:
                    stop_info = PTV_API_CLIENT.get_stop_info(stop_id, route_type)
                    break
                except HTTPError as e:
                    if e.response.status_code == 403:
                        print("API Timeout 30")
                        time.sleep(30)
                        continue
                    else:
                        stop_info = {
                            'stop_id': stop_id,
                            'route_type': route_type,
                            'error': str(e)
                        }
                        print('API', stop_id, route_type, e.response.status_code)
                        break
                
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
all_stops = get_all_stops_info(all_stops_idrt)
PTV_DB['stops'].insert_many(all_stops)


new_stops = complete_stops_info(all_directions_stops)