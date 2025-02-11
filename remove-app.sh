#!/bin/bash
searchTerm=""

# Initialize array to store files safely
file_list=()

# Properly read null-delimited output into array
while IFS= read -r -d '' file; do
    file_list+=("$file")
done < <(mdfind -0 -name "$searchTerm" 2>/dev/null)

echo "Found ${#file_list[@]} files associated with '$searchTerm'"

# Check if array is empty
if [ ${#file_list[@]} -eq 0 ]; then
    echo "No files to remove"
    exit 2
else
    # Process termination section
    pid_list=$(pgrep "$searchTerm")
    if [ -z "$pid_list" ]; then
        echo "No processes to kill"
    else
        echo "Processes Found, Killing processes:"
        for pid in $pid_list; do
            kill -9 "$pid" && echo "Killed process $pid" || echo "Failed to kill process $pid"
        done
    fi

    # File deletion section
    echo "Removing files:"
    for file in "${file_list[@]}"; do
        if rm -rfv -- "$file"; then
            echo "Successfully removed: $file"
        else
            echo "Failed to remove: $file: $output"
            exit 1
        fi
    done
fi

exit 0
