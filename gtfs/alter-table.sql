-- Set "" to NULL
-- UPDATE agency SET agency_name = NULL WHERE agency_name = '';
-- UPDATE agency SET agency_url = NULL WHERE agency_url = '';
-- UPDATE agency SET agency_timezone = NULL WHERE agency_timezone = '';
-- UPDATE agency SET agency_lang = NULL WHERE agency_lang = '';
-- UPDATE calendar SET monday = NULL WHERE monday = '';
-- UPDATE calendar SET tuesday = NULL WHERE tuesday = '';
-- UPDATE calendar SET wednesday = NULL WHERE wednesday = '';
-- UPDATE calendar SET thursday = NULL WHERE thursday = '';
-- UPDATE calendar SET friday = NULL WHERE friday = '';
-- UPDATE calendar SET saturday = NULL WHERE saturday = '';
-- UPDATE calendar SET sunday = NULL WHERE sunday = '';
-- UPDATE calendar SET start_date = NULL WHERE start_date = '';
-- UPDATE calendar SET end_date = NULL WHERE end_date = '';
-- UPDATE calendar_dates SET date = NULL WHERE date = '';
-- UPDATE calendar_dates SET exception_type = NULL WHERE exception_type = '';
-- UPDATE routes SET agency_id = NULL WHERE agency_id = '';
-- UPDATE routes SET route_short_name = NULL WHERE route_short_name = '';
-- UPDATE routes SET route_long_name = NULL WHERE route_long_name = '';
-- UPDATE routes SET route_type = NULL WHERE route_type = '';
-- UPDATE routes SET route_color = NULL WHERE route_color = '';
-- UPDATE routes SET route_text_color = NULL WHERE route_text_color = '';
UPDATE shapes SET shape_pt_lat = NULL WHERE shape_pt_lat = '';
UPDATE shapes SET shape_pt_lon = NULL WHERE shape_pt_lon = '';
UPDATE shapes SET shape_pt_sequence = NULL WHERE shape_pt_sequence = '';
UPDATE shapes SET shape_dist_traveled = NULL WHERE shape_dist_traveled = '';
UPDATE stops SET stop_name = NULL WHERE stop_name = '';
UPDATE stops SET stop_lat = NULL WHERE stop_lat = '';
UPDATE stops SET stop_lon = NULL WHERE stop_lon = '';
UPDATE trips SET route_id = NULL WHERE route_id = '';
UPDATE trips SET service_id = NULL WHERE service_id = '';
UPDATE trips SET shape_id = NULL WHERE shape_id = '';
-- UPDATE trips SET trip_headsign = NULL WHERE trip_headsign = '';
UPDATE trips SET direction_id = NULL WHERE direction_id = '';
-- UPDATE trips SET block_id = NULL WHERE block_id = '';
-- UPDATE stop_times SET arrival_time = NULL WHERE arrival_time = '';
-- UPDATE stop_times SET departure_time = NULL WHERE departure_time = '';
UPDATE stop_times SET stop_id = NULL WHERE stop_id = '';
-- UPDATE stop_times SET stop_headsign = NULL WHERE stop_headsign = '';
-- UPDATE stop_times SET pickup_type = NULL WHERE pickup_type = '';
-- UPDATE stop_times SET drop_off_type = NULL WHERE drop_off_type = '';
UPDATE stop_times SET shape_dist_traveled = NULL WHERE shape_dist_traveled = '';
UPDATE stop_times SET stop_sequence = NULL WHERE stop_sequence = '';


-- Alter table schema
ALTER TABLE calendar 
ALTER COLUMN monday SET DATA TYPE SMALLINT USING monday::SMALLINT;

ALTER TABLE calendar 
ALTER COLUMN tuesday SET DATA TYPE SMALLINT USING tuesday::SMALLINT;

ALTER TABLE calendar 
ALTER COLUMN wednesday SET DATA TYPE SMALLINT USING wednesday::SMALLINT;

ALTER TABLE calendar 
ALTER COLUMN thursday SET DATA TYPE SMALLINT USING thursday::SMALLINT;

ALTER TABLE calendar 
ALTER COLUMN friday SET DATA TYPE SMALLINT USING friday::SMALLINT;

ALTER TABLE calendar 
ALTER COLUMN saturday SET DATA TYPE SMALLINT USING saturday::SMALLINT;

ALTER TABLE calendar 
ALTER COLUMN sunday SET DATA TYPE SMALLINT USING sunday::SMALLINT;

ALTER TABLE calendar_dates
ALTER COLUMN exception_type SET DATA TYPE SMALLINT USING exception_type::SMALLINT;

ALTER TABLE routes
ALTER COLUMN route_type SET DATA TYPE SMALLINT USING route_type::SMALLINT;

ALTER TABLE shapes
ALTER COLUMN shape_pt_sequence SET DATA TYPE INT USING shape_pt_sequence::INT;

ALTER TABLE stops
ALTER COLUMN stop_id SET DATA TYPE INT USING stop_id::INT;

ALTER TABLE stops
ALTER COLUMN stop_lat SET DATA TYPE DECIMAL USING stop_lat::DECIMAL;

ALTER TABLE stops
ALTER COLUMN stop_lon SET DATA TYPE DECIMAL USING stop_lon::DECIMAL;

ALTER TABLE trips
ALTER COLUMN direction_id SET DATA TYPE SMALLINT USING direction_id::SMALLINT;

ALTER TABLE stop_times
ALTER COLUMN stop_id SET DATA TYPE INT USING stop_id::INT;

ALTER TABLE stop_times
ALTER COLUMN stop_sequence SET DATA TYPE SMALLINT USING stop_sequence::SMALLINT;

ALTER TABLE stop_times
ALTER COLUMN pickup_type SET DATA TYPE SMALLINT USING pickup_type::SMALLINT;

ALTER TABLE stop_times
ALTER COLUMN drop_off_type SET DATA TYPE SMALLINT USING drop_off_type::SMALLINT;

ALTER TABLE stop_times
ALTER COLUMN shape_dist_traveled SET DATA TYPE DECIMAL USING shape_dist_traveled::DECIMAL;

-- Enforce foreign key constraints
ALTER TABLE calendar_dates
ADD CONSTRAINT fk_calendar_dates_service_id
FOREIGN KEY (service_id) REFERENCES calendar(service_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trips_route_id
FOREIGN KEY (route_id) REFERENCES routes(route_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trips_service_id
FOREIGN KEY (service_id) REFERENCES calendar(service_id);

ALTER TABLE stop_times
ADD CONSTRAINT fk_stop_times_trip_id
FOREIGN KEY (trip_id) REFERENCES trips(trip_id);

ALTER TABLE stop_times
ADD CONSTRAINT fk_stop_times_stop_id
FOREIGN KEY (stop_id) REFERENCES stops(stop_id);
