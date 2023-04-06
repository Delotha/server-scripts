#! /bin/bash

# This script is to be used with root user's crontab to backup the entire server
# 55 23 * * 6,2 cd /root/server-scripts/ && git fetch --all && git reset --hard origin/master
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
echo "$date-$time: Started." >> /var/log/loudfoot-master-backup.log

# Get the config file
if [ -e "$configfile" ]; then
    source "$configfile"
    sitedest="$dest/sites"
else
    echo "$date-$time: Error: Config file not found ($configfile)." >> /var/log/loudfoot-master-backup.log
    exit 0
fi

if [ -z $user ]; then
    cleanup=$(rm /var/log/loudfoot-master-backup.log)
    exit 0 # Exiting. This is not a server that gets backed up.
fi

cd "$includespath" || exit
for f in *
do
    # Don't try to run the readme file.
    if [ "$f" != "README.md" ]; then
        source "$includespath/$f" .
    fi
done

# If successful, update log file.
echo "$date-$time: Complete." >> /var/log/loudfoot-master-backup.log

exit 0
