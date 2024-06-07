#!/bin/bash

cd data || exit

export task_id="lateral_bc"
export container_name="gulfTaranto_20141005_${task_id}"
export id_exp="gulfTaranto_20141005"
export config_free_filename="configBase_${task_id}.json"

# Set container variables
export nproc=1
export memory="4g"
export shm_size="4g"
export tmp_cleanup="true"
export overwrite="false"

# Set user type and config free
export USER_TYPE="base"
export path_from_gui_host="$(pwd)/from_GUI"

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

# set image name
export image_name="cmccsurf/surf_nemo:X64-dev"

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
            --name $container_name \
            --memory $memory \
            --shm-size $shm_size \
            $image_name

docker rm $container_name