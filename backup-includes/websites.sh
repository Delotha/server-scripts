#!/bin/bash

if [ -n "$users" ]; then
    ##### Websites Back #####
    echo "Backup Sites - Start"

    # Create sites folder
    if [ ! -d "$sitedest" ]; then
        mkdir "$sitedest"
    fi

    for i in "${users[@]}"
    do
    # Tar and compress each /home/<user> listed in array
        tar -zcf "$sitedest/site-backup-$date-${i}.tar.gz" -C /home/ "${i}"
    done
    echo "Backup Sites - Done"
    ##### Websites Done #####
fi
