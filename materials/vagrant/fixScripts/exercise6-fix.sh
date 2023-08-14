#!/bin/bash
#add fix to exercise6-fix here

# seting the source and destination
current_host=$(hostname)
if [ "$current_host" == "server1" ]; then
    source_server="server1"
    destination_server="server2"
else
    source_server="server2"
    destination_server="server1"
fi

# Check if at least 2 arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Please provide at least 1 file path and a destination folder."
    exit 1
fi

# Extract the last argument as the destination folder
destination_folder="${!#}"

total_bytes_copied=0

# Loop through all but the last argument (source file paths)
for ((i = 1; i < $#; i++)); do
    source_path="${!i}"

    # Check if the source file exists
    if [ ! -e "$source_path" ]; then
        echo "Source file '$source_path' does not exist."
        continue
    fi

    file_name=$(basename "$source_path")
    destination_path="$destination_folder/$file_name"

    # Copy the file using scp and update the total bytes copied
    scp "$source_path" "${destination_server}:${destination_path}"
    
    if [ $? -eq 0 ]; then
        total_bytes_copied=$((total_bytes_copied + $(stat -c %s "$source_path")))
        echo "Copied '$source_path' to '$destination_server:$destination_path'."
    else
        echo "Failed to copy '$source_path' to '$destination_server:$destination_path'."
    fi
done

echo "$total_bytes_copied"
