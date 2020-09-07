#!/bin/bash

if [ -f "/etc/rkhunter.conf" ]; then
	###### Copy rkhunter config file #####
	echo "Get /etc/rkhunter.conf - Start"
	cp /etc/rkhunter.conf "$dest"/
	echo "Get /etc/rkhunter.conf - Done"
	##### Copy rkhunter config file #####
fi