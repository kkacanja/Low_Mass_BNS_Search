#!/bin/bash
set -e

# Input directory containing the times files
input_dir="times"

# Loop through each file in the input directory
for file in "$input_dir"/*.ini; do
    # Extract the base filename (without extension)
    filename=$(basename -- "$file")
    base_filename="${filename%.*}"

    # Extract the relevant information from the filename
    if [[ "$base_filename" =~ ^(gps_times_[^_]+_[^_]+) ]]; then
        workflow_type="${BASH_REMATCH[1]}"

        # Create the output directory based on the filename information
        output_dir="${workflow_type}_${base_filename##*_}"
        output_dir="${output_dir/gps_times_/}"
        mkdir -p "$output_dir"

        # Generate a new gen script for each file in the output directory
        output_script="${output_dir}/gen_${base_filename}.sh"

        echo "#!/bin/bash" > "$output_script"
        echo "set -e" >> "$output_script"
        echo "" >> "$output_script"
        echo "pycbc_make_offline_search_workflow \\" >> "$output_script"
        echo "--workflow-name $base_filename \\" >> "$output_script"
        echo "--output-dir output \\" >> "$output_script"
        echo "--config-files ../analasys_final.ini ../plotting_final.ini ../executables_final.ini ../${file} \\" >> "$output_script"
        echo "--config-overrides results_page:output-path:$(pwd)/html" >> "$output_script"
	echo "--submit-now" >> "$output_script"
        # Make the generated script executable
        chmod +x "$output_script"
    else
        echo "Error: Unexpected filename format: $filename"
    fi
done

