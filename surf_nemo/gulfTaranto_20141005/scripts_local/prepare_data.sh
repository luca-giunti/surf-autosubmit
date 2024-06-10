#!/bin/bash

cd $exp_folder/proj/git/project/surf_nemo/gulfTaranto_20141005/data || exit

# Inflate the main dataset
tar -xzf surf_datasets_tailored.tar.gz

# Inflate datasets offline
for archive in datasets_offline/*.tar.gz; do
    tar -xzf $archive -C datasets_offline
done

cd - || exit
