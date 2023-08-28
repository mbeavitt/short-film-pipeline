#!/bin/bash

# Check for directory argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

# Directory provided as argument
dir="$1"

# Name of the folder to store converted videos
output_folder="$dir/1080p_converted"

# Create the folder if it doesn't exist
mkdir -p "$output_folder"

for i in "$dir"/*.MOV; do
    # Extract filename without path
    filename=$(basename -- "$i")
    # Path to save the converted video
    output_path="$output_folder/${filename%.MOV}_1080p.MOV"

    # Modified FFmpeg command
    ffmpeg -i "$i" -vf "scale=-1:1080" -c:v libx264 -preset medium -pix_fmt yuv420p -profile:v high -level:v 4.0 -movflags +faststart -c:a copy "$output_path"
done
