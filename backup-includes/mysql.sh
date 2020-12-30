#!/bin/bash

mysql="mysql"

# Check if MySQL is installed
installed=$(apt-cache policy mysql-server | grep "Installed: (none)")
if [[ $installed == "" ]]; then
	runme=1
fi

# Check if MariaDB is installed
installed=$(apt-cache policy mariadb-server | grep "Installed: (none")
if [[ $installed == "" ]]; then
	mysql="mariadb"
	runme=1
fi

if [[ $runme -gt 0 ]]; then
	##### MySQL Back #####
	echo "Backup MySQL/MariaDB - Start"

	mkdir "$dest/$mysql"

	# Take the backups
	out=$(mysql -e 'show databases' -s --skip-column-names)
	for DB in $out; do
# Ignore system databases
		case $DB in
		'information_schema')
			;;
		'mysql')
			;;
		'performance_schema')
			;;
		'phpmyadmin')
			;;
		*)
			dump=$(mysqldump "$DB" > "$dest"/$mysql/"$DB.sql";)
#		echo "Exported: $DB"
		esac
	done

	# Grab my.cnf file
	out=$(cp /etc/mysql/my.cnf "$dest"/)


	echo 'Backup MySQL/MariaDB - Done'
	##### MySQL Done #####
fi
