#!/bin/bash

##### Set permissions on backups #####
echo "Set Permissions - Start"
chown -R "$user":"$user" "$dest"
echo "Set Permissions - Done"
##### Permissions set #####
