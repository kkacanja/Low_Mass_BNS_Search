#!/bin/bash

source /home/kkacanja/miniconda3/etc/profile.d/conda.sh
conda activate astro

set -e

start_time=$(date +%s)

echo "Start time: ${start_time} "

#Note that this is the bank generation for only one tau0 bin. to generate the full bank generale all the tau0 bins

pycbc_brute_bank \
--input-config main_config.ini \
--output-file 360.0-380.0.hdf \
--approximant TaylorF2 \
--psd-file o3psd.txt \
--low-frequency-cutoff 25.0 \
--max-signal-length 512 \
--tau0-crawl 1 \
--tau0-start 360.0 \
--tau0-end 365.0 \
--tau0-threshold 0.5 \
--minimal-match 0.95 \
--verbose

end_time=$(date +%s)

echo "End time: ${end_time}"

elapsed_time=$((end_time - start_time))

echo "Script completed in ${elapsed_time} seconds."
