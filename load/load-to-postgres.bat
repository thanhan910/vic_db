set PGPASSWORD=postgres
psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE vic_db OWNER postgres ENCODING 'UTF8' CONNECTION LIMIT -1"
psql -U postgres -h localhost -p 5432 -d vic_db -c "CREATE EXTENSION IF NOT EXISTS postgis"
psql -U postgres -h localhost -p 5432 -d vic_db -c "CREATE SCHEMA IF NOT EXISTS ptv"
psql -U postgres -h localhost -p 5432 -d vic_db -c "CREATE SCHEMA IF NOT EXISTS vmadd"
psql -U postgres -h localhost -p 5432 -d vic_db -c "CREATE SCHEMA IF NOT EXISTS vmtrans"
echo Loading ptv.ptv_metro_bus_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_bus_route.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_METRO_BUS_ROUTE.shp" "ptv.ptv_metro_bus_route" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_bus_route.log"
echo Finished loading ptv.ptv_metro_bus_route
echo Finished loading ptv.ptv_metro_bus_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_bus_route.log"
echo Loading ptv.ptv_metro_bus_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_bus_stop.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_METRO_BUS_STOP.shp" "ptv.ptv_metro_bus_stop" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_bus_stop.log"
echo Finished loading ptv.ptv_metro_bus_stop
echo Finished loading ptv.ptv_metro_bus_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_bus_stop.log"
echo Loading ptv.ptv_metro_train_station >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_train_station.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_METRO_TRAIN_STATION.shp" "ptv.ptv_metro_train_station" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_train_station.log"
echo Finished loading ptv.ptv_metro_train_station
echo Finished loading ptv.ptv_metro_train_station >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_train_station.log"
echo Loading ptv.ptv_metro_tram_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_tram_route.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_METRO_TRAM_ROUTE.shp" "ptv.ptv_metro_tram_route" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_tram_route.log"
echo Finished loading ptv.ptv_metro_tram_route
echo Finished loading ptv.ptv_metro_tram_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_tram_route.log"
echo Loading ptv.ptv_metro_tram_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_tram_stop.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_METRO_TRAM_STOP.shp" "ptv.ptv_metro_tram_stop" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_tram_stop.log"
echo Finished loading ptv.ptv_metro_tram_stop
echo Finished loading ptv.ptv_metro_tram_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_metro_tram_stop.log"
echo Loading ptv.ptv_regional_bus_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_bus_route.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_REGIONAL_BUS_ROUTE.shp" "ptv.ptv_regional_bus_route" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_bus_route.log"
echo Finished loading ptv.ptv_regional_bus_route
echo Finished loading ptv.ptv_regional_bus_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_bus_route.log"
echo Loading ptv.ptv_regional_bus_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_bus_stop.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_REGIONAL_BUS_STOP.shp" "ptv.ptv_regional_bus_stop" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_bus_stop.log"
echo Finished loading ptv.ptv_regional_bus_stop
echo Finished loading ptv.ptv_regional_bus_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_bus_stop.log"
echo Loading ptv.ptv_regional_coach_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_coach_route.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_REGIONAL_COACH_ROUTE.shp" "ptv.ptv_regional_coach_route" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_coach_route.log"
echo Finished loading ptv.ptv_regional_coach_route
echo Finished loading ptv.ptv_regional_coach_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_coach_route.log"
echo Loading ptv.ptv_regional_coach_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_coach_stop.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_REGIONAL_COACH_STOP.shp" "ptv.ptv_regional_coach_stop" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_coach_stop.log"
echo Finished loading ptv.ptv_regional_coach_stop
echo Finished loading ptv.ptv_regional_coach_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_coach_stop.log"
echo Loading ptv.ptv_regional_train_station >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_train_station.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_REGIONAL_TRAIN_STATION.shp" "ptv.ptv_regional_train_station" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_train_station.log"
echo Finished loading ptv.ptv_regional_train_station
echo Finished loading ptv.ptv_regional_train_station >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_regional_train_station.log"
echo Loading ptv.ptv_skybus_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_skybus_route.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_SKYBUS_ROUTE.shp" "ptv.ptv_skybus_route" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_skybus_route.log"
echo Finished loading ptv.ptv_skybus_route
echo Finished loading ptv.ptv_skybus_route >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_skybus_route.log"
echo Loading ptv.ptv_skybus_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_skybus_stop.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_SKYBUS_STOP.shp" "ptv.ptv_skybus_stop" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_skybus_stop.log"
echo Finished loading ptv.ptv_skybus_stop
echo Finished loading ptv.ptv_skybus_stop >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_skybus_stop.log"
echo Loading ptv.ptv_train_carpark >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_carpark.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_TRAIN_CARPARK.shp" "ptv.ptv_train_carpark" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_carpark.log"
echo Finished loading ptv.ptv_train_carpark
echo Finished loading ptv.ptv_train_carpark >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_carpark.log"
echo Loading ptv.ptv_train_corridor_centreline >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_corridor_centreline.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_TRAIN_CORRIDOR_CENTRELINE.shp" "ptv.ptv_train_corridor_centreline" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_corridor_centreline.log"
echo Finished loading ptv.ptv_train_corridor_centreline
echo Finished loading ptv.ptv_train_corridor_centreline >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_corridor_centreline.log"
echo Loading ptv.ptv_train_station_bike_storage >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_station_bike_storage.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_TRAIN_STATION_BIKE_STORAGE.shp" "ptv.ptv_train_station_bike_storage" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_station_bike_storage.log"
echo Finished loading ptv.ptv_train_station_bike_storage
echo Finished loading ptv.ptv_train_station_bike_storage >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_station_bike_storage.log"
echo Loading ptv.ptv_train_station_platform >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_station_platform.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_TRAIN_STATION_PLATFORM.shp" "ptv.ptv_train_station_platform" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_station_platform.log"
echo Finished loading ptv.ptv_train_station_platform
echo Finished loading ptv.ptv_train_station_platform >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_station_platform.log"
echo Loading ptv.ptv_train_track_centreline >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_track_centreline.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_TRAIN_TRACK_CENTRELINE.shp" "ptv.ptv_train_track_centreline" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_track_centreline.log"
echo Finished loading ptv.ptv_train_track_centreline
echo Finished loading ptv.ptv_train_track_centreline >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_train_track_centreline.log"
echo Loading ptv.ptv_tram_track_centreline >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_tram_track_centreline.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\PTV\PTV_TRAM_TRACK_CENTRELINE.shp" "ptv.ptv_tram_track_centreline" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_tram_track_centreline.log"
echo Finished loading ptv.ptv_tram_track_centreline
echo Finished loading ptv.ptv_tram_track_centreline >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\ptv.ptv_tram_track_centreline.log"
echo Loading vmadd.address >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmadd.address.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\VMADD\ADDRESS.shp" "vmadd.address" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmadd.address.log"
echo Finished loading vmadd.address
echo Finished loading vmadd.address >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmadd.address.log"
echo Loading vmadd.address_1 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmadd.address_1.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\VMADD\ADDRESS_1.shp" "vmadd.address_1" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmadd.address_1.log"
echo Finished loading vmadd.address_1
echo Finished loading vmadd.address_1 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmadd.address_1.log"
echo Loading vmtrans.tr_road_all >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_all.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\VMTRANS\TR_ROAD_ALL.shp" "vmtrans.tr_road_all" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_all.log"
echo Finished loading vmtrans.tr_road_all
echo Finished loading vmtrans.tr_road_all >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_all.log"
echo Loading vmtrans.tr_road_infrastructure_all >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_infrastructure_all.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\VMTRANS\TR_ROAD_INFRASTRUCTURE_ALL.shp" "vmtrans.tr_road_infrastructure_all" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_infrastructure_all.log"
echo Finished loading vmtrans.tr_road_infrastructure_all
echo Finished loading vmtrans.tr_road_infrastructure_all >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_infrastructure_all.log"
echo Loading vmtrans.tr_road_register >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_register.log"
shp2pgsql -s 7844 "C:\Users\An\Documents\GitHub\PTV\local\datashare\data\VMTRANS\TR_ROAD_REGISTER.shp" "vmtrans.tr_road_register" | psql -d vic_db -U postgres -h localhost -p 5432 >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_register.log"
echo Finished loading vmtrans.tr_road_register
echo Finished loading vmtrans.tr_road_register >> "C:\Users\An\Documents\GitHub\PTV\local\logs\vic_db\vmtrans.tr_road_register.log"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN numofstops TO num_of_stops; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN triphdsign TO trip_headsign; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN routelongn TO route_long_name; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN lastspname TO last_stop_name; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN laststid TO last_stop_id; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN firststnam TO first_stop_name; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN operator TO operator_name; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN firstspid TO first_stop_id; ALTER TABLE ptv.ptv_metro_bus_route RENAME COLUMN routeshtnm TO route_short_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_metro_bus_stop RENAME COLUMN routeussp TO routes_using_stop;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_metro_train_station RENAME COLUMN routeussp TO routes_using_stop;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN firstspid TO first_stop_id; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN routelongn TO route_long_name; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN lastspname TO last_stop_name; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN operator TO operator_name; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN numofstops TO num_of_stops; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN triphdsign TO trip_headsign; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN firststnam TO first_stop_name; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN laststid TO last_stop_id; ALTER TABLE ptv.ptv_metro_tram_route RENAME COLUMN routeshtnm TO route_short_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_metro_tram_stop RENAME COLUMN routeussp TO routes_using_stop;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN numofstops TO num_of_stops; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN firststnam TO first_stop_name; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN firstspid TO first_stop_id; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN laststid TO last_stop_id; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN lastspname TO last_stop_name; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN routeshtnm TO route_short_name; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN triphdsign TO trip_headsign; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN operator TO operator_name; ALTER TABLE ptv.ptv_regional_bus_route RENAME COLUMN routelongn TO route_long_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_regional_bus_stop RENAME COLUMN routeussp TO routes_using_stop;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN lastspname TO last_stop_name; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN triphdsign TO trip_headsign; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN operator TO operator_name; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN routeshtnm TO route_short_name; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN numofstops TO num_of_stops; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN firststnam TO first_stop_name; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN routelongn TO route_long_name; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN laststid TO last_stop_id; ALTER TABLE ptv.ptv_regional_coach_route RENAME COLUMN firstspid TO first_stop_id;"
psql -U postgres -h localhost -p 5432 -d vic_db -c ""
psql -U postgres -h localhost -p 5432 -d vic_db -c ""
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN laststid TO last_stop_id; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN operator TO operator_name; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN numofstops TO num_of_stops; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN firststnam TO first_stop_name; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN firstspid TO first_stop_id; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN routeshtnm TO route_short_name; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN routelongn TO route_long_name; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN triphdsign TO trip_headsign; ALTER TABLE ptv.ptv_skybus_route RENAME COLUMN lastspname TO last_stop_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_skybus_stop RENAME COLUMN routeussp TO routes_using_stop;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_train_carpark RENAME COLUMN com_capac TO commuter_capacity; ALTER TABLE ptv.ptv_train_carpark RENAME COLUMN station TO station_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_train_corridor_centreline RENAME COLUMN segment TO segment_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_train_station_bike_storage RENAME COLUMN station TO station_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_train_station_platform RENAME COLUMN station TO station_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_train_track_centreline RENAME COLUMN electric TO electrified; ALTER TABLE ptv.ptv_train_track_centreline RENAME COLUMN fac_name TO facility_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE ptv.ptv_tram_track_centreline RENAME COLUMN fac_name TO facility_name;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE vmadd.address RENAME COLUMN bunit_id1 TO blg_unit_id_1; ALTER TABLE vmadd.address RENAME COLUMN fl_pref1 TO floor_prefix_1; ALTER TABLE vmadd.address RENAME COLUMN bunit_pre1 TO blg_unit_prefix_1; ALTER TABLE vmadd.address RENAME COLUMN complex TO complex_name; ALTER TABLE vmadd.address RENAME COLUMN fl_suf2 TO floor_suffix_2; ALTER TABLE vmadd.address RENAME COLUMN disp_suf2 TO disp_suffix_2; ALTER TABLE vmadd.address RENAME COLUMN building TO building_name; ALTER TABLE vmadd.address RENAME COLUMN out_prop TO outside_property; ALTER TABLE vmadd.address RENAME COLUMN add_class TO address_class; ALTER TABLE vmadd.address RENAME COLUMN rd_suf TO road_suffix; ALTER TABLE vmadd.address RENAME COLUMN src_verif TO source_verified; ALTER TABLE vmadd.address RENAME COLUMN fl_pref2 TO floor_prefix_2; ALTER TABLE vmadd.address RENAME COLUMN disp_num1 TO disp_number_1; ALTER TABLE vmadd.address RENAME COLUMN bunit_id2 TO blg_unit_id_2; ALTER TABLE vmadd.address RENAME COLUMN hse_num1 TO house_number_1; ALTER TABLE vmadd.address RENAME COLUMN pfi_cr TO pfi_created; ALTER TABLE vmadd.address RENAME COLUMN ezi_add TO ezi_address; ALTER TABLE vmadd.address RENAME COLUMN hse_pref2 TO house_prefix_2; ALTER TABLE vmadd.address RENAME COLUMN bunit_pre2 TO blg_unit_prefix_2; ALTER TABLE vmadd.address RENAME COLUMN complxsite TO complex_site; ALTER TABLE vmadd.address RENAME COLUMN accesstype TO add_access_type; ALTER TABLE vmadd.address RENAME COLUMN disp_pref2 TO disp_prefix_2; ALTER TABLE vmadd.address RENAME COLUMN loc_desc TO location_descriptor; ALTER TABLE vmadd.address RENAME COLUMN disp_suf1 TO disp_suffix_1; ALTER TABLE vmadd.address RENAME COLUMN hse_num2 TO house_number_2; ALTER TABLE vmadd.address RENAME COLUMN num_rd_add TO num_road_address; ALTER TABLE vmadd.address RENAME COLUMN hse_suf1 TO house_suffix_1; ALTER TABLE vmadd.address RENAME COLUMN hsaunitid TO hsa_unit_id; ALTER TABLE vmadd.address RENAME COLUMN fqid TO feature_quality_id; ALTER TABLE vmadd.address RENAME COLUMN pr_pfi TO property_pfi; ALTER TABLE vmadd.address RENAME COLUMN bunit_suf2 TO blg_unit_suffix_2; ALTER TABLE vmadd.address RENAME COLUMN dist_flag TO distance_related_flag; ALTER TABLE vmadd.address RENAME COLUMN disp_pref1 TO disp_prefix_1; ALTER TABLE vmadd.address RENAME COLUMN locality TO locality_name; ALTER TABLE vmadd.address RENAME COLUMN hse_pref1 TO house_prefix_1; ALTER TABLE vmadd.address RENAME COLUMN num_add TO num_address; ALTER TABLE vmadd.address RENAME COLUMN bunit_suf1 TO blg_unit_suffix_1; ALTER TABLE vmadd.address RENAME COLUMN fl_suf1 TO floor_suffix_1; ALTER TABLE vmadd.address RENAME COLUMN label_add TO label_address; ALTER TABLE vmadd.address RENAME COLUMN ufi_cr TO ufi_created; ALTER TABLE vmadd.address RENAME COLUMN blgunttyp TO blg_unit_type; ALTER TABLE vmadd.address RENAME COLUMN gcodefeat TO geocode_feature; ALTER TABLE vmadd.address RENAME COLUMN propstatus TO property_status; ALTER TABLE vmadd.address RENAME COLUMN hse_suf2 TO house_suffix_2; ALTER TABLE vmadd.address RENAME COLUMN disp_num2 TO disp_number_2;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE vmadd.address_1 RENAME COLUMN bunit_id1 TO blg_unit_id_1; ALTER TABLE vmadd.address_1 RENAME COLUMN fl_pref1 TO floor_prefix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN bunit_pre1 TO blg_unit_prefix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN complex TO complex_name; ALTER TABLE vmadd.address_1 RENAME COLUMN fl_suf2 TO floor_suffix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN disp_suf2 TO disp_suffix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN building TO building_name; ALTER TABLE vmadd.address_1 RENAME COLUMN out_prop TO outside_property; ALTER TABLE vmadd.address_1 RENAME COLUMN add_class TO address_class; ALTER TABLE vmadd.address_1 RENAME COLUMN rd_suf TO road_suffix; ALTER TABLE vmadd.address_1 RENAME COLUMN src_verif TO source_verified; ALTER TABLE vmadd.address_1 RENAME COLUMN fl_pref2 TO floor_prefix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN disp_num1 TO disp_number_1; ALTER TABLE vmadd.address_1 RENAME COLUMN bunit_id2 TO blg_unit_id_2; ALTER TABLE vmadd.address_1 RENAME COLUMN hse_num1 TO house_number_1; ALTER TABLE vmadd.address_1 RENAME COLUMN pfi_cr TO pfi_created; ALTER TABLE vmadd.address_1 RENAME COLUMN ezi_add TO ezi_address; ALTER TABLE vmadd.address_1 RENAME COLUMN hse_pref2 TO house_prefix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN bunit_pre2 TO blg_unit_prefix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN complxsite TO complex_site; ALTER TABLE vmadd.address_1 RENAME COLUMN accesstype TO add_access_type; ALTER TABLE vmadd.address_1 RENAME COLUMN disp_pref2 TO disp_prefix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN loc_desc TO location_descriptor; ALTER TABLE vmadd.address_1 RENAME COLUMN disp_suf1 TO disp_suffix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN hse_num2 TO house_number_2; ALTER TABLE vmadd.address_1 RENAME COLUMN num_rd_add TO num_road_address; ALTER TABLE vmadd.address_1 RENAME COLUMN hse_suf1 TO house_suffix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN hsaunitid TO hsa_unit_id; ALTER TABLE vmadd.address_1 RENAME COLUMN fqid TO feature_quality_id; ALTER TABLE vmadd.address_1 RENAME COLUMN pr_pfi TO property_pfi; ALTER TABLE vmadd.address_1 RENAME COLUMN bunit_suf2 TO blg_unit_suffix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN dist_flag TO distance_related_flag; ALTER TABLE vmadd.address_1 RENAME COLUMN disp_pref1 TO disp_prefix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN locality TO locality_name; ALTER TABLE vmadd.address_1 RENAME COLUMN hse_pref1 TO house_prefix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN num_add TO num_address; ALTER TABLE vmadd.address_1 RENAME COLUMN bunit_suf1 TO blg_unit_suffix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN fl_suf1 TO floor_suffix_1; ALTER TABLE vmadd.address_1 RENAME COLUMN label_add TO label_address; ALTER TABLE vmadd.address_1 RENAME COLUMN ufi_cr TO ufi_created; ALTER TABLE vmadd.address_1 RENAME COLUMN blgunttyp TO blg_unit_type; ALTER TABLE vmadd.address_1 RENAME COLUMN gcodefeat TO geocode_feature; ALTER TABLE vmadd.address_1 RENAME COLUMN propstatus TO property_status; ALTER TABLE vmadd.address_1 RENAME COLUMN hse_suf2 TO house_suffix_2; ALTER TABLE vmadd.address_1 RENAME COLUMN disp_num2 TO disp_number_2;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE vmtrans.tr_road_all RENAME COLUMN coordauthc TO coordinating_auth_code; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name6 TO road_name_6; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name5 TO road_name_5; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse1 TO road_name_use_1; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN crdate_ufi TO create_date_ufi; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN right_loc TO right_locality; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN structname TO structure_name; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse7 TO road_name_use_7; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse3 TO road_name_use_3; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse5 TO road_name_use_5; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse4 TO road_name_use_4; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name1 TO road_name_1; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN ftype_code TO feature_type_code; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf7 TO road_suffix_7; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf3 TO road_suffix_3; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type3 TO road_type_3; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN fqid TO feature_quality_id; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN respauthcd TO responsible_auth_code; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN vecaccess TO vehicular_access; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN left_loc TO left_locality; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_status TO road_status; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN cons_mat TO construction_material; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN restrictn TO restrictions; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf5 TO road_suffix_5; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN const_type TO construction_type; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse TO road_name_use; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN ezi_rdname TO ezi_road_name; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type4 TO road_type_4; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN super_pfi TO superceded_pfi; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf6 TO road_suffix_6; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type2 TO road_type_2; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN ldlmtassdt TO load_limit_assess_date; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name4 TO road_name_4; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf2 TO road_suffix_2; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type6 TO road_type_6; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN dir_code TO direction_code; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name2 TO road_name_2; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse2 TO road_name_use_2; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name3 TO road_name_3; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rdnameuse6 TO road_name_use_6; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type1 TO road_type_1; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf4 TO road_suffix_4; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN ht_limit TO height_limit; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN seasopendt TO seasonal_open_date; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf TO road_suffix; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type5 TO road_type_5; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN phys_cond TO physical_condition; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN nfeat_id TO named_feature_id; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_suf1 TO road_suffix_1; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_name7 TO road_name_7; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN rd_type7 TO road_type_7; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN seasclsedt TO seasonal_close_date; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN crdate_pfi TO create_date_pfi; ALTER TABLE vmtrans.tr_road_all RENAME COLUMN ezirdnmlbl TO ezi_road_name_label;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN ldlmtassdt TO load_limit_assess_date; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN super_pfi TO superceded_pfi; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN respauthcd TO responsible_auth_code; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN fqid TO feature_quality_id; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN crdate_ufi TO create_date_ufi; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN cons_mat TO construction_material; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN ftype_code TO feature_type_code; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN phys_cond TO physical_condition; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN struc_type TO structure_type; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN const_type TO construction_type; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN coordauthc TO coordinating_auth_code; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN ht_limit TO height_limit; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN crdate_pfi TO create_date_pfi; ALTER TABLE vmtrans.tr_road_infrastructure_all RENAME COLUMN nfeat_id TO named_feature_id;"
psql -U postgres -h localhost -p 5432 -d vic_db -c "ALTER TABLE vmtrans.tr_road_register RENAME COLUMN gaz_url TO gazettal_url; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN nuniq_loc TO nonunique_locality; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN minclasscd TO min_class_code; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN rd_suf TO road_suffix; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN gazregn TO gazettal_registration; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN ezi_rdname TO ezi_road_name; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN crdate_pfi TO create_date_pfi; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN rdn_gender TO road_name_gender; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN gazettal TO gazettal_date; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN vicnamesid TO vicnames_id; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN rdnamethem TO road_name_theme; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN rdnameuse TO road_name_use; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN ezirdnmlbl TO ezi_road_name_label; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN loc_rd_id TO locality_road_id; ALTER TABLE vmtrans.tr_road_register RENAME COLUMN crdate_ufi TO create_date_ufi;"
