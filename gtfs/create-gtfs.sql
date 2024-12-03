DROP SCHEMA IF EXISTS gtfs_1 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_1;
SET search_path TO gtfs_1;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_2 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_2;
SET search_path TO gtfs_2;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_3 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_3;
SET search_path TO gtfs_3;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_4 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_4;
SET search_path TO gtfs_4;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_5 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_5;
SET search_path TO gtfs_5;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_6 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_6;
SET search_path TO gtfs_6;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_7 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_7;
SET search_path TO gtfs_7;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_8 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_8;
SET search_path TO gtfs_8;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_10 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_10;
SET search_path TO gtfs_10;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
DROP SCHEMA IF EXISTS gtfs_11 CASCADE;
CREATE SCHEMA IF NOT EXISTS gtfs_11;
SET search_path TO gtfs_11;
CREATE TABLE agency (
    agency_id TEXT,
    agency_name TEXT NULL,
    agency_url TEXT NULL,
    agency_timezone TEXT NULL,
    agency_lang TEXT NULL,
    PRIMARY KEY (agency_id)
);
CREATE TABLE calendar (
    service_id TEXT,
    monday TEXT NULL,
    tuesday TEXT NULL,
    wednesday TEXT NULL,
    thursday TEXT NULL,
    friday TEXT NULL,
    saturday TEXT NULL,
    sunday TEXT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type TEXT NULL,
    PRIMARY KEY (service_id, date)
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type TEXT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    -- FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat TEXT NULL,
    shape_pt_lon TEXT NULL,
    shape_pt_sequence TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id TEXT,
    stop_name TEXT NULL,
    stop_lat TEXT NULL,
    stop_lon TEXT NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id TEXT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id)
    -- FOREIGN KEY (route_id) REFERENCES routes(route_id),
    -- FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    -- FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id TEXT NULL,
    stop_sequence TEXT,
    stop_headsign TEXT NULL,
    pickup_type TEXT NULL,
    drop_off_type TEXT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    -- FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    -- FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);

