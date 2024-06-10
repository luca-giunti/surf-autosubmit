#!/bin/bash

export scratch_dir_path="."
cd ${scratch_dir_path}/data || exit

# Inflate the main dataset
tar -xzf surf_datasets_tailored.tar.gz

# Inflate datasets offline
for archive in datasets_offline/*.tar.gz; do
    tar -xzf $archive -C datasets_offline
done

cd - || exit
