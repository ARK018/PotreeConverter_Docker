@echo off
REM Windows batch script to run PotreeConverter in Docker

REM Check if input file is provided
if "%1"=="" (
    echo Usage: convert.bat ^<input_las_file^> [output_name]
    echo Example: convert.bat input\pointcloud.las my_potree_output
    exit /b 1
)

REM Set input file and output name
set INPUT_FILE=%1
set OUTPUT_NAME=%2
if "%OUTPUT_NAME%"=="" set OUTPUT_NAME=myviewer

REM Create input and pointclouds directories if they don't exist
if not exist "input" mkdir input
if not exist "pointclouds" mkdir pointclouds

REM Copy input file to input directory if it's not already there
if not exist "input\%~nx1" (
    copy "%INPUT_FILE%" "input\"
)

REM Build the Docker image
echo Building Docker image...
docker-compose build

REM Run the conversion
echo Converting %~nx1 to Potree format...
docker-compose run --rm potree-converter -i /app/input/%~nx1 -o /app/pointclouds/%OUTPUT_NAME%

echo Conversion complete! Output available in: pointclouds\%OUTPUT_NAME%
