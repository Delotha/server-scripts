#!/bin/bash

if [ -f "/etc/iptables.rules" ]; then
    ##### Copy firewall rules file #####
    echo "Get /etc/iptables.rules - Start"
    cp /etc/iptables.rules "$dest"/
    echo "Get /etc/iptables.rules - Done"
    ##### Copy firewall rules file #####
fi