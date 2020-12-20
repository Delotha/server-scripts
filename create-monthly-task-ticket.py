#!/usr/bin/python3
# Loudfoot Mantis API Scripts: Create Monthly Tasks ticket for Loudfoot/Delotha

import os
import datetime
import requests
import socket
import configparser

# Get hostname
hostname = socket.gethostname()

# Create parser object and read config file
# TODO: Check if this file exists. Exit immediately if it doesn't.
config = configparser.RawConfigParser()
configfile = '/etc/server-scripts/mantis-create-monthly-ticket-' + hostname + '.cfg'
config.read(configfile)

# Loop through all sections (which are company names)
for company in config.sections():

	#TODO Make sure we found all the required variables
#	errors = 0
#	if not "mantis_token" in company.keys():
#		print('No MANTIS_TOKEN found in dotenv file.')
#		errors += 1
#	if not "mantis_url" in company.keys():
#		print('No MANTIS_URL found in dotenv file.')
#		errors += 1
#	if not "mantis_category" in company.keys():
#		print('No MANTIS_CATEGORY found in dotenv file.')
#		errors += 1
#	if not "mantis_project" in company.keys():
#		print('No MANTIS_PROJECT found in dotenv file.')
#		errors += 1
#	if not "mantis_monthly_description" in company.keys():
#		print('No MANTIS_MONTHLY_DESCRIPTION found in dotenv file.')
#		errors += 1
#	if errors > 0:
#		exit()

	# Build the ticket name with the YYYY and Month
	now = datetime.datetime.now()
	name = 'Monthly Tasks - ' + now.strftime("%Y %B")

	# CURL call stuff:
	api_url = config.get(company, "mantis_url") + '/api/rest/issues/'
	data = { 'summary': name, 'description': config.get(company, "mantis_monthly_description"), 'category': {'name': config.get(company, "mantis_category")}, 'project': {'name': config.get(company, "mantis_project")} }
	headers = { 'Authorization': config.get(company, "mantis_token") }

	# Make the actual call
	response = requests.post(api_url, json=data, headers=headers)

#	Debug stuff 
#	print(api_url) # DEBUG
#	print(data) # DEBUG
#	print(headers) # DEBUG

exit()
