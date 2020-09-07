This is a repository of scripts that I call to backup different things, depending on if it's installed or not.

## Requirements
Each script should:
1. Have a method to check if the required service is installed, if it is intended to backup the configuration or data from a service
2. Output when it starts and ends, so this can be output to a log file or viewed when running it manually
3. Use global variables for important information from the parent script (ex. $date, $dest, $users) 

## How to Use
This is how I call it: (fill in the parts in <these brackets> for yourself)

	date=$(date +%F)
	time=$(date +%H%M%S)
	user="<username>"
	dest="<backup-destination-path>/$HOSTNAME-$date-$time-full"
	
	# Get list of website users
	if [ ! -e "./$HOSTNAME/users.sh" ]; then
		exit 0
	fi
	source "./$HOSTNAME/users.sh"
	sitedest="$dest/sites"
	
	includespath=$(find / -name backup-includes | head -1)
	cd "$includespath"
	for f in *
	do
		cd "$includespath"
		source "$f" .
	done
