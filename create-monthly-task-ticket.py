#!/usr/bin/python3
# Loudfoot Mantis API Scripts: Create Monthly Tasks ticket for Loudfoot/Delotha

import os
import datetime
import requests
import socket

# Get hostname
hostname = socket.gethostname()

# Get variables from the config file (which Loudfoot usually keeps in /etc/server-scripts/)
from dotenv import load_dotenv, find_dotenv
from pathlib import Path
env_path = Path('/etc/server-scripts') / hostname + '.env'
load_dotenv(dotenv_path=env_path)

TOKEN = os.getenv('MANTIS_TOKEN')
URL = os.getenv('MANTIS_URL')
CATEGORY = os.getenv('MANTIS_CATEGORY')
PROJECT = os.getenv('MANTIS_PROJECT')
DESCRIPTION = os.getenv('MANTIS_MONTHLY_DESCRIPTION')

# Make sure we found all the required variables
errors = 0
if not TOKEN:
	print('No MANTIS_TOKEN found in dotenv file.')
	errors += 1
if not URL:
	print('No MANTIS_URL found in dotenv file.')
	errors += 1
if not CATEGORY:
	print('No MANTIS_CATEGORY found in dotenv file.')
	errors += 1
if not PROJECT:
	print('No MANTIS_PROJECT found in dotenv file.')
	errors += 1
if not DESCRIPTION:
	print('No MANTIS_MONTHLY_DESCRIPTION found in dotenv file.')
	errors += 1
if errors > 0:
	exit()

# Build the ticket name with the YYYY and Month
now = datetime.datetime.now()
name = 'Monthly Tasks - ' + now.strftime("%Y %B")

# CURL call stuff:
api_url = URL + '/api/rest/issues/'
data = { 'summary': name, 'description': DESCRIPTION, 'category': {'name': CATEGORY}, 'project': {'name': PROJECT} }
headers = { 'Authorization': TOKEN }

# Make the actual call
#response = requests.post(api_url, json=data, headers=headers)

exit()
