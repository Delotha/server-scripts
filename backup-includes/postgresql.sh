#!/bin/bash

installed=$(apt-cache policy postgresql | grep "Installed: (none)")
if [[ $installed == "" ]]
then
    ##### PostgreSQL Back #####
    echo "Backup Postgres - Start"
    # Create postgresql folder
    if [ ! -d "$dest/postgresql" ]; then
        mkdir "$dest"/postgresql
    fi
    cd /tmp/
    sudo -u postgres pg_dumpall -c | gzip > "$dest"/postgresql/postgres.sql.gz
    cp /etc/postgresql/*/main/postgresql.conf "$dest"/postgresql/
    cp /etc/postgresql/*/main/pg_hba.conf "$dest"/postgresql/
    echo "Backup Postgres - Done"
    ##### PostgreSQL Done #####
fi