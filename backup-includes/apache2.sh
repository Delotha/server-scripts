#!/bin/bash

installed=$(apt-cache policy apache2 | grep "Installed: (none)")
if [[ $installed == "" ]]
then
    ##### Copy Apache VirtualHost files #####
    echo "Get Apache VirtualHost files - Start"

        tar -cf "$dest"/apache2.tar -C /etc/apache2/ apache2.conf
        tar -rf "$dest"/apache2.tar -C /etc/apache2/ sites-available
        tar -rf "$dest"/apache2.tar -C /etc/apache2/ sites-enabled
 
    echo "Get Apache VirtualHost files - Done"
    ##### Copy Apache VirtualHost files #####
fi