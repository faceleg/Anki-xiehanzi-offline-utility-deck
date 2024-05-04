#!/bin/zsh

# Set the locale to UTF-8 to handle Unicode filenames correctly.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Define the data directory and output TSV file name
data_dir="./data"
tsv_file="$data_dir/xiehanzi_offline_data.tsv"
json_dir="$data_dir/json_files"

# URL of the GitHub repository zip.
repo_url="https://github.com/chanind/hanzi-writer-data/archive/refs/heads/master.zip"

# Temporary directory for storing the downloaded zip.
temp_dir="./hanzi_writer_data_temp"

# Download the repository zip file.
echo "Downloading repository..."
curl -L "$repo_url" --output "$temp_dir.zip"

# Extract the downloaded file into the temporary directory using ditto.
echo "Extracting files..."
mkdir -p "$temp_dir"  # Ensure the extraction directory exists.
ditto -x -k "$temp_dir.zip" "$temp_dir"
echo "Extraction complete."

# Ensure the data directory, JSON directory, and output directories exist.
mkdir -p "$json_dir"
[[ ! -f "$tsv_file" ]] && touch "$tsv_file"

# Find all matching .json files, excluding 'all.json'.
files=($(find "$temp_dir/hanzi-writer-data-master/data" -type f -name "*.json" ! -name "all.json"))

# Count of total files to process.
total_files=${#files}
current_file=0

# Iterate over matched *.json files.
for file in "${files[@]}"; do
    # Update file count.
    ((current_file++))

    # Extract filename without path and extension.
    filename="${file:t:r}"

    # Prepare the line to be added to the TSV.
    line="_$filename\t[_$filename.json]\txiehanzi-offline-utility-note"

    # Append the line to the output TSV file.
    echo -e "$line" >> "$tsv_file"

    # Copy the file to the JSON directory with the prefix '_'.
    cp "$file" "$json_dir/_$filename.json"

    # Print progress bar.
    percent=$(( 100 * $current_file / $total_files ))
    printf "\rProgress: [%-50s] %d%%" $(printf '#%.0s' {1..$((percent / 2))}) $percent
done

echo "\nTSV file has been updated and files have been copied."

# Clean up the temporary directory.
rm -rf "$temp_dir" "$temp_dir.zip"
