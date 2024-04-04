@REM Check the progress of loading a file into the database by checking the log file for the string "INSERT 0 1"

@echo off
if "%~1"=="" (
    echo Usage: %0 [path_to_file]
    exit /b 1
)

echo Searching for "INSERT 0 1"...
:loop
findstr /C:"INSERT 0 1" "%~1" | find /C /V ""
timeout /t 1 >nul
goto :loop
