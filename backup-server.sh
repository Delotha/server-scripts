#! /bin/bash

# This script is to be used with root user's crontab to backup the entire server
# 0 6 * * * /root/server-scripts/backup-server.sh

# Variables
date=$(date +%F)
time=$(date +%H:%M:%S)
configfile="/etc/serverscripts/$HOSTNAME.config"

# Update log file that we've started
echo "$date-$time: Started." >> /tmp/loudfoot-backup-server-script.log

# Get the config file
if [ -e "$configfile" ]; then
	source "$configfile"
	sitedest="$dest/sites"
else
	echo "$date-$time: Error: Config file not found ($configfile)." >> /tmp/loudfoot-master-backup.log
	exit 0
fi

whoami=$(whoami)
if [ $whoami != $user ]; then
	echo "$date-$time: Error: Not running as the correct user ($whoami instead of $whois)" >> /tmp/loudfoot-backup-server-script.log
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
echo "$date-$time: Complete." >> /tmp/loudfoot-backup-server-script.log

exit 0
