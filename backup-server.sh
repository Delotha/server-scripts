#! /bin/bash

# This script is to be used with root user's crontab to backup the entire server
# 0 6 * * * /root/server-scripts/backup-server.sh

# Variables
date=$(date +%F)
time=$(date +%H:%M:%S)
configfile="/etc/serverscripts/$HOSTNAME.config"

# Update log file that we've started
echo "$date-$time: Started." >> /var/log/loudfoot-backup-server-script.log

# Get the config file
if [ -e "$configfile" ]; then
	source "$configfile"
	sitedest="$dest/sites"
else
	echo "$date-$time: Error: Config file not found ($configfile)." >> /var/log/loudfoot-master-backup.log
	exit 0
fi

for i in "${servers[@]}"
do
	if [ ! -e "$basedest/${i}" ]; then
		mkdir -p "$basedest/${i}"
	fi
	src="$user@${i}:$dest"
	dest="$basedest/${i}"

case "$1" in
	--purge)
		rsync "$src" "$dest" -rtv --delete-after
	;;
	*)
		rsync "$src" "$dest" -rt
	;;
esac

done

# Update log file of our success
echo "$date-$time: Complete." >> /var/log/loudfoot-backup-server-script.log

exit 0
