#!/bin/bash

source /home/kkacanja/miniconda3/etc/profile.d/conda.sh
conda activate astro

set -e

start_time=$(date +%s)

echo "Start time: ${start_time} "

/home/kkacanja/low_mass_search/gen_bank/pycbc_brute_bank \
--input-config /home/kkacanja/low_mass_search/gen_bank/main_config.ini \
--output-file /home/kkacanja/low_mass_search/banks/fixed_l_25hz/360.0-380.0.hdf \
--approximant TaylorF2 \
--psd-file /home/kkacanja/low_mass_search/gen_bank/o3psd.txt \
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
