#!/bin/bash

# Check if ufw is active
active=$(ufw status | head -1 | grep "active")
if [[ $active != "" ]]; then
	exit 0
fi

##### ufw Back #####
echo "Backup ufw - Start"

# Take the backups
out=$(ufw status >> $dest/ufw-status.txt)

echo 'Backup ufw - Done'
##### ufw Done #####
