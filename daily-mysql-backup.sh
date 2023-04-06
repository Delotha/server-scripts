#! /bin/bash

# This script is to be used with root user's crontab to backup the MySQL/MariaDB server every day
# 55 23 * * 6,2 cd /root/server-scripts/ && git fetch --all && git reset --hard origin/master (deprecated location because I've put it in Puppet)
# 0 0 * * 0,3 cd /root/server-scripts/ && /root/server-scripts/master-backup.sh

if [[ $(id -u) -ne 0 ]] ; then
    echo "This script needs to be run as root or with sudo. Exiting."
    exit 1
fi

# Variables
# No quotes for date because of error "command not found"
date=$(date +%F)
time=$(date +%H%M%S)
configfile="/etc/server-scripts/$HOSTNAME.config"
includespath="/usr/share/server-scripts/backup-includes"

# Update log file that we've started
echo "$date-$time: Started." >> /var/log/loudfoot-daily-mysql-backup.log

# Get the config file
if [ -e "$configfile" ]; then
    source "$configfile"
    dest="/home/$user/backups/$HOSTNAME-$date-$time-mysql"
else
    echo "$date-$time: Error: Config file not found ($configfile)." >> /var/log/loudfoot-daily-mysql-backup.log
    exit 0
fi

if [ -z $user ]; then
    cleanup=$(rm /var/log/loudfoot-daily-mysql-backup.log)
    exit 0 # Exiting. This is not a server that gets backed up.
fi

source "$includespath/00-create-folder.sh"
source "$includespath/mysql.sh"
source "$includespath/xx-permissions.sh"

# If successful, update log file.
echo "$date-$time: Complete." >> /var/log/loudfoot-daily-mysql-backup.log

exit 0
