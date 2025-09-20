# PotreeConverter Docker Setup

This Docker setup allows you to run PotreeConverter (Linux binary) on Windows to convert LAS files to Potree format.

## Prerequisites

- Docker Desktop installed on Windows
- Docker Compose (included with Docker Desktop)

## Quick Start


### Method 1: Using Docker Hub Image (No Build Required)

If you want to use the pre-built image from Docker Hub:

1. **Update docker-compose.yml to use Docker Hub image:**
   ```yaml
   Comment out: build: .
   Use: image: akshay627/potree-converter:latest
   ```

2. **Run the conversion:**
   ```cmd
   .\convert.bat <Path to input file> <Path to output folder>
   ```

### Method 2: Manual Docker Commands (Build Locally)
   ```

1. **Run the conversion:**
   ```cmd
   .\convert.bat <Path to input file> <Path to output folder>
   ```

## Directory Structure

```
Dhatuveda_Docker/
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Docker Compose configuration
├── PotreeConverter         # Linux binary (your existing file)
├── convert.bat             # Windows helper script
├── input/                  # Place your LAS files here
├── pointclouds/            # Converted Potree files appear here
│   └── myviewer/           # Default output location
└── README.md               # This file
```


## Docker Hub

This image is also available on Docker Hub: **`akshay627/potree-converter:latest`**

To use the pre-built image instead of building locally:
1. Update your `docker-compose.yml`
2. Comment out `build: .`
3. Use `image: akshay627/potree-converter:latest`

## Troubleshooting

### Common Issues:

1. **PowerShell script execution:**
   ```cmd
   .\convert.bat your_file.las
   ```
   (Note the `.\` prefix in PowerShell)

2. **Docker not found:**
   - Ensure Docker Desktop is installed and running

3. **File not found:**
   - Make sure your LAS file exists and the path is correct
   - Check that the file was copied to the `input/` directory

4. **Container fails to start:**
   - Try rebuilding the image: `docker-compose build --no-cache`
   - Or pull fresh from Docker Hub: `docker pull akshay627/potree-converter:latest`

### Getting Help:

To see PotreeConverter help:
```cmd
docker-compose run --rm potree-converter --help
```

## Output

The converted Potree files will be available in the `pointclouds/myviewer/` directory (or your custom output name). You can then serve these files using a web server to view the point cloud in a browser.

