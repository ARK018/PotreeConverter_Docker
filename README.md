# PotreeConverter Docker Setup

This Docker setup allows you to run PotreeConverter (Linux binary) on Windows to convert LAS files to Potree format.

## Prerequisites

- Docker Desktop installed on Windows
- Docker Compose (included with Docker Desktop)

## Quick Start

### Method 1: Using the Helper Script (Recommended)

**For Windows:**
```cmd
.\convert.bat path\to\your\file.las [output_name]
```

Example (using default output name "myviewer"):
```cmd
.\convert.bat Test.laz
```

Example with custom output name:
```cmd
.\convert.bat C:\data\pointcloud.las my_potree_project
```

### Method 2: Using Docker Hub Image (No Build Required)

If you want to use the pre-built image from Docker Hub:

1. **Update docker-compose.yml to use Docker Hub image:**
   ```yaml
   Comment out: build: .
   Use: image: akshay627/potree-converter:latest
   ```

2. **Create input and pointclouds directories:**
   ```cmd
   mkdir input pointclouds
   ```

3. **Copy your LAS file to the input directory:**
   ```cmd
   copy your_file.las input\
   ```

4. **Run the conversion:**
   ```cmd
   docker-compose run --rm potree-converter -i /app/input/your_file.las -o /app/pointclouds/myviewer
   ```

### Method 3: Manual Docker Commands (Build Locally)

1. **Build the Docker image:**
   ```cmd
   docker-compose build
   ```

2. **Create input and pointclouds directories:**
   ```cmd
   mkdir input pointclouds
   ```

3. **Copy your LAS file to the input directory:**
   ```cmd
   copy your_file.las input\
   ```

4. **Run the conversion:**
   ```cmd
   docker-compose run --rm potree-converter -i /app/input/your_file.las -o /app/pointclouds/myviewer
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

## PotreeConverter Options

You can pass any PotreeConverter arguments. Common options include:

- `-i <input>` - Input LAS file
- `-o <output>` - Output directory
- `--spacing <value>` - Point spacing (default: auto)
- `--levels <value>` - Number of levels (default: auto)
- `--format <format>` - Output format (LAZ, LAS, BINARY)

Example with custom options:
```cmd
docker-compose run --rm potree-converter -i /app/input/data.las -o /app/pointclouds/custom --spacing 0.1 --levels 5
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

## Notes

- The Docker container runs the Linux version of PotreeConverter
- Input files are mounted read-only for safety
- Output files are written with proper permissions for Windows access
- Default output name is `myviewer` - can be customized with second parameter
- Uses `pointclouds/` directory instead of `output/` for better organization
