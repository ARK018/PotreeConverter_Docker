# Use Ubuntu as base image for Linux compatibility
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies including LAS/LAZ support
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglu1-mesa \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libxrandr2 \
    libxss1 \
    libgconf-2-4 \
    libasound2 \
    libatk1.0-0 \
    libdrm2 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxinerama1 \
    libxss1 \
    libgtk-3-0 \
    liblaszip8 \
    liblaszip-dev \
    libboost-all-dev \
    libgomp1 \
    libtbb12 \
    libtbb-dev \
    libc6 \
    libgcc-s1 \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the PotreeConverter binary
COPY PotreeConverter /app/PotreeConverter

# Make the binary executable
RUN chmod +x /app/PotreeConverter

# Check what libraries the binary needs (for debugging)
RUN ldd /app/PotreeConverter || echo "ldd failed - binary might be statically linked or have missing dependencies"

# Create directories for input and pointclouds
RUN mkdir -p /app/input /app/pointclouds

# Set the binary as the entry point
ENTRYPOINT ["/app/PotreeConverter"]

# Default command (can be overridden)
CMD ["--help"]
