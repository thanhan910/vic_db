set PGPASSWORD=postgres
psql -U postgres -h localhost -p 5432 -c "CREATE DATABASE vic_db OWNER postgres ENCODING 'UTF8' CONNECTION LIMIT -1"
psql -U postgres -h localhost -p 5432 -d vic_db -c "CREATE EXTENSION IF NOT EXISTS postgis"