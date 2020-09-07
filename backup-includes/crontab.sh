#!/bin/bash

##### Copy Crontab files #####
echo "Get Crontab files - Start"
tar -cf "$dest"/crontab.tar -C / var/spool/cron/crontabs
echo "Get Crontab files - Done"
##### Copy Crontab files #####
