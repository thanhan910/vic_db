# Generate SQL script to create GTFS tables for all modes

# Define the path to the create-table.sql file
$createSqlFilePath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -ChildPath "create-table.sql"

# Read the content of create-table.sql
$createGtfsSql = Get-Content -Path $createSqlFilePath -Raw

# Initialize an empty string for the full SQL script
$fullSqlScript = ""

# Loop through the mode IDs and generate the SQL script for each mode
$modeIds = 1, 2, 3, 4, 5, 6, 7, 8, 10, 11
foreach ($modeId in $modeIds) {
    $schemaName = "gtfs_$modeId"
    $tableCreateSql = @"
DROP SCHEMA IF EXISTS $schemaName CASCADE;
CREATE SCHEMA IF NOT EXISTS $schemaName;
SET search_path TO $schemaName;
$createGtfsSql
"@
    $fullSqlScript += $tableCreateSql
}

# Define the path to the output SQL file
$sqlFilePath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -ChildPath "create-gtfs.sql"

# Write the full SQL script to the output file
Set-Content -Path $sqlFilePath -Value $fullSqlScript


# Generate SQL script to alter GTFS tables for all modes

# Define the path to the alter-table.sql file
$createSqlFilePath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -ChildPath "alter-table.sql"

# Read the content of alter-table.sql
$createGtfsSql = Get-Content -Path $createSqlFilePath -Raw

# Initialize an empty string for the full SQL script
$fullSqlScript = ""

# Loop through the mode IDs and generate the SQL script for each mode
$modeIds = 1, 2, 3, 4, 5, 6, 7, 8, 10, 11
foreach ($modeId in $modeIds) {
    $schemaName = "gtfs_$modeId"
    $tableCreateSql = @"
SET search_path TO $schemaName;
$createGtfsSql
"@
    $fullSqlScript += $tableCreateSql
}

# Define the path to the output SQL file
$sqlFilePath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -ChildPath "alter-gtfs.sql"

# Write the full SQL script to the output file
Set-Content -Path $sqlFilePath -Value $fullSqlScript