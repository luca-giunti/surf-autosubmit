#!/bin/bash

cd data || exit

# Inflate the main dataset
tar -xzf "surf_datasets_tailored.tar.gz" -C "surf_datasets_tailored"

# Inflate datasets offline
for archive in datasets_offline/*.tar.gz; do
    tar -xzf "$archive" -C "datasets_offline"
done

# Set container variables
export nproc=8
export id_exp="gulfTaranto_20141005"
export memory="4g"
export shm_size="4g"
export tmp_cleanup="true"
export overwrite="false"

# Set user type and config free
export USER_TYPE="base"
export path_from_gui_host="$(pwd)/from_GUI"
export config_free_filename="configBase.json"

# Set mount points for shared volumes on the host
export path_experiments_host="/tmp/Experiments" && mkdir -p $path_experiments_host
export path_datasets_host="$(pwd)/surf_datasets_tailored"
export path_datasets_experiment_offline_host="$(pwd)/datasets_offline"
export path_datasets_precomputed_host=""

# Set mount points for shared volumes inside the container (fixed)
export path_from_gui_container="/media/shared_volumes/From_GUI"
export path_experiment_container="/media/shared_volumes/Experiment"
export path_datasets_container="/media/shared_volumes/Datasets"
export path_datasets_experiment_offline_container="/media/shared_volumes/Datasets_Experiment_Offline"
export path_datasets_precomputed_container="/media/shared_volumes/Datasets_Precomputed"

cd - || exit

docker run -e ID_EXP=$id_exp \
            -e OVERWRITE=$overwrite \
            -e TMP_CLEANUP=$tmp_cleanup \
            -e USER_TYPE=$USER_TYPE \
            -e CONFIG_FREE_FILENAME=$config_free_filename \
            -e nproc=$nproc \
            -v ${path_from_gui_host}:${path_from_gui_container} \
            -v ${path_experiments_host}:${path_experiment_container} \
            -v ${path_datasets_host}:${path_datasets_container} \
            -v ${path_datasets_experiment_offline_host}:${path_datasets_experiment_offline_container} \
            ${path_datasets_precomputed_host:+-v ${path_datasets_precomputed_host}:${path_datasets_precomputed_container}} \
            --name $id_exp \
            --memory $memory \
            --shm-size $shm_size \
            $1