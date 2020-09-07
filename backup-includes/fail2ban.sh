#!/bin/bash

installed=$(apt-cache policy fail2ban | grep "Installed: (none)")
if [[ $installed == "" ]]
then
	##### Copy fail2ban configuration #####
	echo "Get fail2ban config - Start"

	cp /etc/fail2ban/jail.local "$dest"

	echo "Get fail2ban config - Done"
	##### Copy fail2ban configuration #####
fi