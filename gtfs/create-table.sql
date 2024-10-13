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
    monday SMALLINT NULL,
    tuesday SMALLINT NULL,
    wednesday SMALLINT NULL,
    thursday SMALLINT NULL,
    friday SMALLINT NULL,
    saturday SMALLINT NULL,
    sunday SMALLINT NULL,
    start_date TEXT NULL,
    end_date TEXT NULL,
    PRIMARY KEY (service_id)
);
CREATE TABLE calendar_dates (
    service_id TEXT,
    date TEXT NULL,
    exception_type SMALLINT NULL,
    PRIMARY KEY (service_id, date),
    FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);
CREATE TABLE routes (
    route_id TEXT,
    agency_id TEXT NULL,
    route_short_name TEXT NULL,
    route_long_name TEXT NULL,
    route_type SMALLINT NULL,
    route_color TEXT NULL,
    route_text_color TEXT NULL,
    PRIMARY KEY (route_id)
    FOREIGN KEY (agency_id) REFERENCES agency(agency_id)
);
CREATE TABLE shapes (
    shape_id TEXT,
    shape_pt_lat DECIMAL NULL,
    shape_pt_lon DECIMAL NULL,
    shape_pt_sequence INT NULL,
    shape_dist_traveled TEXT NULL,
    PRIMARY KEY (shape_id, shape_pt_sequence)
);
CREATE TABLE stops (
    stop_id INT,
    stop_name TEXT NULL,
    stop_lat DECIMAL NULL,
    stop_lon DECIMAL NULL,
    PRIMARY KEY (stop_id)
);
CREATE TABLE trips (
    route_id TEXT NULL,
    service_id TEXT NULL,
    trip_id TEXT,
    shape_id TEXT NULL,
    trip_headsign TEXT NULL,
    direction_id SMALLINT NULL,
    block_id TEXT NULL,
    PRIMARY KEY (trip_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (service_id) REFERENCES calendar(service_id)
    FOREIGN KEY (shape_id) REFERENCES shapes(shape_id)
);
CREATE TABLE stop_times (
    trip_id TEXT,
    arrival_time TEXT NULL,
    departure_time TEXT NULL,
    stop_id INT NULL,
    stop_sequence SMALLINT,
    stop_headsign TEXT NULL,
    pickup_type SMALLINT NULL,
    drop_off_type SMALLINT NULL,
    shape_dist_traveled DECIMAL NULL,
    PRIMARY KEY (trip_id, stop_sequence)
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
