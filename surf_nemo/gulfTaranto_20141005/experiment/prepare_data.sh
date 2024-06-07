#!/bin/bash

export scratch_dir_remote="/home/onyxia/work/test/linuxserver.io/"
cd ${scratch_dir_remote}/data || exit

# Inflate the main dataset
tar -xzf surf_datasets_tailored.tar.gz

# Inflate datasets offline
for archive in datasets_offline/*.tar.gz; do
    tar -xzf $archive -C datasets_offline
done

cd - || exit
