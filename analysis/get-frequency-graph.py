import os
import plotly.graph_objects as go
import pandas as pd
import psycopg2
from datetime import datetime, timedelta


def plot_timetable_rectangles(start_stop: str, end_stop: str, my_day_str: str, mode_id: int, cursor: psycopg2.extensions.cursor) -> tuple[go.Figure, pd.DataFrame]:
    """
    Plot timetable rectangles
    """

    my_weekday_name = datetime.strptime(my_day_str, '%Y%m%d').strftime('%A').lower()

    CURSOR.execute(
    f'''
    SELECT gtfs_{mode_id}.stop_times.departure_time, gtfs_{mode_id}.stop_times.trip_id, gtfs_{mode_id}.stop_times.stop_sequence, gtfs_{mode_id}.stop_times.stop_id, gtfs_{mode_id}.routes.route_short_name, gtfs_{mode_id}.routes.route_long_name
    FROM gtfs_{mode_id}.stop_times 
    JOIN gtfs_{mode_id}.trips USING (trip_id)
    JOIN gtfs_{mode_id}.routes USING (route_id)
    JOIN gtfs_{mode_id}.calendar USING (service_id)
    WHERE (stop_id = '{start_stop}' OR stop_id = '{end_stop}')
    AND {my_weekday_name} = '1'
    AND start_date <= '{my_day_str}'
    AND end_date >= '{my_day_str}'    
    ORDER BY departure_time ASC, stop_sequence ASC;
    '''
    )

    potential_trips = CURSOR.fetchall()

    trips_to_start_stop_record : dict[str, dict[str, str]] = {}
    correct_trips : dict[str, str] = {}

    for departure_time, trip_id, stop_sequence, stop_id, route_short_name, route_long_name in potential_trips:

        if stop_id == start_stop:
            trips_to_start_stop_record[trip_id] = {'departure_time': departure_time, 'stop_sequence': stop_sequence}

        if stop_id == end_stop and trip_id in trips_to_start_stop_record and int(trips_to_start_stop_record[trip_id]['stop_sequence']) <= int(stop_sequence):
            correct_trips[trip_id] = {
                'trip_id': trip_id,
                'departure_time': trips_to_start_stop_record[trip_id]['departure_time'],
                'arrival_end': departure_time,
                'route_short_name': route_short_name,
                'route_long_name': route_long_name,
            }

    if len(correct_trips) == 0:
        return None, None

    selected_trips_df = pd.DataFrame(correct_trips.values())

    departure_info = selected_trips_df.groupby('departure_time')['route_short_name'].apply(lambda x: ', '.join(x)).to_dict()
    # sort departure_info by departure_time
    assert all(k.endswith(":00") for k in sorted(departure_info))
    departure_info = {k.removesuffix(":00"): departure_info[k] for k in sorted(departure_info)}

    departure_minutes : list[int] = []

    for departure_time in departure_info.keys():
        departure_h = int(departure_time[:2])
        departure_m = int(departure_time[3:])
        departure_minutes.append(departure_h * 60 + departure_m)

    # departure_seconds = sorted(list(set(departure_seconds)))
    departure_minutes = sorted(departure_minutes)

    departure_intervals = []
    for i in range(0, len(departure_minutes) - 1):
        start_time = departure_minutes[i]
        end_time = departure_minutes[i+1]
        width = end_time - start_time
        departure_intervals.append(width)
    max_interval = max(departure_intervals)
    assert max_interval < 60
    max_interval = 60

    # Create rectangles
    departure_shapes = []
    for i in range(0, len(departure_minutes) - 1):
        start_time = departure_minutes[i]
        end_time = departure_minutes[i+1]
        width = end_time - start_time
        height = 60 / width

        interval_minutes = width // 60
        interval_seconds = width % 60

        tooltip_text = f'Interval: {width} min <br>Frequency: {height:.2f} / Hour'

        shape = dict(
            type='scatter',
            x=[start_time, end_time, end_time, start_time, start_time],
            y=[0, 0, height, height, 0],
            mode='lines',
            fill='toself',
            fillcolor='blue',
            line=dict(color='blue'),
            opacity=0.5,
            hoverinfo='text',  # Specify tooltip content
            text=tooltip_text
        )
        departure_shapes.append(shape)

    # Create layout
    layout = dict(
        xaxis=dict(
            title='Time',
            tickvals=departure_minutes,
            # ticktext=[datetime.fromtimestamp(t).strftime('%H:%M') for t in departure_seconds]
            ticktext=[f'{departure_time} - {routes}'for departure_time, routes in departure_info.items()]
        ),
        yaxis=dict(
            title='Frequency / Hour'
        )
    )

    # Create figure
    fig = go.Figure(data=departure_shapes, layout=layout)

    # Show plot

    return fig, selected_trips_df

def plot_frequency_by_interval(my_day_str, start_stop, end_stop, mode_id, interval_value_in_minutes, cursor: psycopg2.extensions.cursor) -> tuple[go.Figure, pd.DataFrame]:
    """
    Plot number of departures in each of an interval (e.g. 1 hour, 30 minutes, 15 minutes)
    """

    my_weekday_name = datetime.strptime(my_day_str, '%Y%m%d').strftime('%A').lower()

    CURSOR.execute(
    f'''
    SELECT gtfs_{mode_id}.stop_times.departure_time, gtfs_{mode_id}.stop_times.trip_id, gtfs_{mode_id}.stop_times.stop_sequence, gtfs_{mode_id}.stop_times.stop_id, gtfs_{mode_id}.routes.route_short_name, gtfs_{mode_id}.routes.route_long_name
    FROM gtfs_{mode_id}.stop_times 
    JOIN gtfs_{mode_id}.trips USING (trip_id)
    JOIN gtfs_{mode_id}.routes USING (route_id)
    JOIN gtfs_{mode_id}.calendar USING (service_id)
    WHERE (stop_id = '{start_stop}' OR stop_id = '{end_stop}')
    AND {my_weekday_name} = '1'
    AND start_date <= '{my_day_str}'
    AND end_date >= '{my_day_str}'
    ORDER BY departure_time ASC, stop_sequence ASC;
    '''
    )

    potential_trips = CURSOR.fetchall()

    trips_to_start_stop_record : dict[str, dict[str, str]] = {}
    correct_trips : dict[str, str] = {}

    for departure_time, trip_id, stop_sequence, stop_id, route_short_name, route_long_name in potential_trips:

        if stop_id == start_stop:
            trips_to_start_stop_record[trip_id] = {'departure_time': departure_time, 'stop_sequence': stop_sequence}

        if stop_id == end_stop and trip_id in trips_to_start_stop_record and int(trips_to_start_stop_record[trip_id]['stop_sequence']) <= int(stop_sequence):
            correct_trips[trip_id] = {
                'trip_id': trip_id,
                'departure_time': trips_to_start_stop_record[trip_id]['departure_time'],
                'arrival_end': departure_time,
                'route_short_name': route_short_name,
                'route_long_name': route_long_name,
            }

    if len(correct_trips) == 0:
        return None, None

    selected_trips_df = pd.DataFrame(correct_trips.values())

    departure_info = selected_trips_df.groupby('departure_time')['route_short_name'].apply(lambda x: ', '.join(x)).to_dict()
    # sort departure_info by departure_time
    assert all(k.endswith(":00") for k in sorted(departure_info))
    departure_info = {k.removesuffix(":00"): departure_info[k] for k in sorted(departure_info)}

    # Plot frequency of departure times

    departure_minutes : list[int] = []

    for departure_time in departure_info.keys():
        departure_h = int(departure_time[:2])
        departure_m = int(departure_time[3:])
        departure_minutes.append(departure_h * 60 + departure_m)

    # departure_seconds = sorted(list(set(departure_seconds)))
    departure_minutes = sorted(departure_minutes)

    departure_interval_dict = {}
    for i in range(0, len(departure_minutes)):
        start_time = departure_minutes[i]
        start_hour = start_time // interval_value_in_minutes
        end_hour = start_hour + 1
        if start_hour not in departure_interval_dict:
            departure_interval_dict[start_hour] = {'count': 0, 'start': start_hour * interval_value_in_minutes, 'end': end_hour * interval_value_in_minutes}
        if i == 0:
            departure_interval_dict[start_hour]['start'] = start_time
        if i == len(departure_minutes) - 1:
            departure_interval_dict[start_hour]['end'] = start_time
        departure_interval_dict[start_hour]['count'] += 1
        
    # Create rectangles
    departure_shapes = []
    for obj in departure_interval_dict.values():
        start_time = obj['start']
        end_time = obj['end']
        width = end_time - start_time
        height = obj['count']

        tooltip_text = f'Interval: {width} min <br>Frequency: {height}'

        shape = dict(
            type='scatter',
            x=[start_time, end_time, end_time, start_time, start_time],
            y=[0, 0, height, height, 0],
            mode='lines',
            fill='toself',
            fillcolor='blue',
            line=dict(color='blue'),
            opacity=0.5,
            hoverinfo='text',  # Specify tooltip content
            text=tooltip_text
        )
        departure_shapes.append(shape)



    # Create layout
    layout = dict(
        xaxis=dict(
            title='Time',
            tickvals=[f'{obj['start']}'for obj in departure_interval_dict.values()] + [f'{list(departure_interval_dict.values())[-1]['end']}'],
            # ticktext=[datetime.fromtimestamp(t).strftime('%H:%M') for t in departure_seconds]
            ticktext=[f'{timedelta(minutes=obj['start'])}' for obj in departure_interval_dict.values()] + [f'{timedelta(minutes=list(departure_interval_dict.values())[-1]['end'])}']
        ),
        yaxis=dict(
            title='Frequency'
        )
    )

    # Create figure
    fig = go.Figure(data=departure_shapes, layout=layout)

    return fig, selected_trips_df


if __name__ == '__main__':    

    CONN = psycopg2.connect(dbname='vic_db', user='postgres', password='postgres', host='localhost', port='5432')
    CONN.autocommit = True
    CURSOR = CONN.cursor()

    my_day_str = '20240723'
    start_stop = '19842'
    end_stop = '19843'
    mode_id = 2
    interval_value_in_minutes = 60
    
    fig, departure_minutes_df = plot_frequency_by_interval(my_day_str, start_stop, end_stop, mode_id, interval_value_in_minutes, CURSOR)
    fig2, departure_minutes_df_2 = plot_timetable_rectangles(start_stop, end_stop, my_day_str, mode_id, CURSOR)

    start_stop_name = CURSOR.execute(f"SELECT stop_name FROM gtfs_{mode_id}.stops WHERE stop_id = '{start_stop}'")
    start_stop_name = CURSOR.fetchone()[0]

    end_stop_name = CURSOR.execute(f"SELECT stop_name FROM gtfs_{mode_id}.stops WHERE stop_id = '{end_stop}'")
    end_stop_name = CURSOR.fetchone()[0]

    output_dir = f'./local/frequencies/{mode_id}-{my_day_str}-{start_stop}-{end_stop}'
    os.makedirs(output_dir, exist_ok=True)

    if fig is not None and fig2 is not None and departure_minutes_df is not None and departure_minutes_df_2 is not None:
        fig.write_html(f'{output_dir}/interval-{interval_value_in_minutes}.html')
        fig2.write_html(f'{output_dir}/timetable.html')
        departure_minutes_df.to_csv(f'{output_dir}/timetable.csv', index=False)
        with open(f'{output_dir}/README.md', 'w') as f:
            f.write(f'{start_stop_name} to {end_stop_name} on {my_day_str} for mode {mode_id}. ID: {start_stop} to {end_stop}.')