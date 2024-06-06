#!/bin/bash

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