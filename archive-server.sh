#! /bin/bash

# This script is to be used with root user's crontab to backup the entire server
# 0 6 * * * /root/server-scripts/backup-server.sh

# Variables
date=$(date +%F)
time=$(date +%H:%M:%S)
configfile="/etc/server-scripts/$HOSTNAME.config"

# Update log file that we've started
echo "$date-$time: Started." >> ~/loudfoot-archive-server.log

# Get the config file
if [ -e "$configfile" ]; then
	source "$configfile"
	sitedest="$dest/sites"
else
	echo "$date-$time: Error: Config file not found ($configfile)." >> ~/loudfoot-archive-server.log
	exit 0
fi

if [ -z $userdest ]; then
	cleanup=$(rm ~/loudfoot-archive-server.log)
	exit 0 # Exiting. This is not a server that gets backed up.
fi


whoami=$(whoami)
if [ $whoami != $userdest ]; then
	echo "$date-$time: Error: Not running as the correct user ($whoami instead of $whois)" >> ~/loudfoot-archive-server.log
fi

for i in "${servers[@]}"
do
	src="$usersrc@${i}:$basesrc/"
	dest="$basedest/${i}"
	if [ ! -e "$dest" ]; then
		mkdir -p "$dest"
	fi

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
echo "$date-$time: Complete." >> ~/loudfoot-archive-server.log

exit 0
