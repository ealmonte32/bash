#!/bin/bash
#ealmonte

####################################################################################################
# example finalized URL:
# https://www.virustotal.com/gui/url/805a94723aec052d53b4c2a61d6268ad7dae71c696477cc3e0a524496bc99063/detection
#
# URLs require http:// or https:// , and must end with / at end
#
# URL must be converted to SHA256
# using shasum: echo -n "http://url.com/" | shasum -a 256 | awk '{print $1}'
# using openssl: echo -n "http://url.com/" | openssl dgst -sha256
#
# curl arguments:
# -m is for max time in seconds to spend before exiting
# -s is for silent
# -k is for allowing connections to SSL sites without certs
# -I is for retrieving header info only
#
# for debugging, echo to the log file ~/Desktop/checkvt.log
#
# it is best practice to name variables with underscore "_" in the beginning of the variable name in order
# to never conflict with built-in/pointers names that interpreters have 
#
#
# a note for the awk part:
# the /^[Ll]ocation:/" part makes it only print the Location (or "location") header
# and sub("\r", "", $2) deletes the carriage return from $2 before it's printed
####################################################################################################

#line by line debugging, turn on: set -x, turn off: set +x
set -x


# VirusTotal base URL
_VTBASEURL=https://www.virustotal.com/gui/url/


# get input of URL to check
read -p "Enter the URL to check: " _REGURL
echo "The entered URL was: ${_REGURL}" >> ~/Desktop/checkvt.log

# check if the URL doesnt have http or https protocol
if [[ "${_REGURL}" != *'http:'* && "${_REGURL}" != *'https:'* ]]
then
	# add http at beginning of REGURL because almost all https enforced sites will redirect from their http
	_REGURL="http://${_REGURL}"
	echo "The entered URL did not contain http or https." >> ~/Desktop/checkvt.log
	echo "http has been added, url is now: ${_REGURL}" >> ~/Desktop/checkvt.log
fi


# check REGURL for redirect:
_CHECKURL=$(curl -m 5 -skI "$_REGURL" | awk '/^[Ll]ocation:/ {sub("\r", "", $2); print $2}')


# check if checkurl is empty, if so, it means no redirect location was found
if [[ -z "${_CHECKURL}" ]]
then
	echo "(no redirect): the checked url does not contain any redirect." >> ~/Desktop/checkvt.log

	# the regular entered url needs to end with a /
	if [[ "${_REGURL}" != *'/' ]] # this wildcard checks the end of a string for character /
	then
		# add / at end of the entered URL if it is not found
		_REGURL+='/'
		echo "The entered URL did not contain a / at end, so it was added." >> ~/Desktop/checkvt.log
		echo "The url is now ${_REGURL}" >> ~/Desktop/checkvt.log
	fi

	# since no redirect exist, we use _REGURL
	# we must sha256 the entered URL
	_SHAURL=$(echo -n "${_REGURL}" | openssl dgst -sha256)

	# then we combine it with the virus total base URL
	_FINALURL="${_VTBASEURL}${_SHAURL}"

	# then we open the combined final URL
	echo "The non-redirected final URL was: ${_FINALURL}" >> ~/Desktop/checkvt.log
	open "${_FINALURL}"

else
	echo "(redirect found): the checked url variable contains a redirect to: ${_CHECKURL}" >> ~/Desktop/checkvt.log
	echo "The new redirected URL is now ${_CHECKURL}" >> ~/Desktop/checkvt.log

	# while the URL contains any reference to a redirect location, keep on assigning it to the variable
	while [[ ! -z "${_CHECKURL}" ]]
	do
		_REDIRECTURL=$(curl -m 5 -skI "$_CHECKURL" | awk '/^[Ll]ocation:/ {sub("\r", "", $2); print $2}')
		if [[ -z "${_REDIRECTURL}" ]]
		then
			_LASTCHECKURL="${_CHECKURL}"
			unset _CHECKURL # we clear the variable so that the while loop stops
			echo "no more redirects found" >> ~/Desktop/checkvt.log
		else
			_CHECKURL="${_REDIRECTURL}"
			echo "(redirect found): the URL contains a redirect to ${_REDIRECTURL}" >> ~/Desktop/checkvt.log
		fi

	done

	# if the last checked URL does not contain http or https, we need to add it
	if [[ "${_LASTCHECKURL}" != *'http:'* && "${_LASTCHECKURL}" != *'https:'* ]]
	then
		# add http at beginning of REGURL because almost all https enforced sites will redirect from their http
		_LASTCHECKURL="http://${_LASTCHECKURL}"
		echo "The last checked URL did not contain http or https." >> ~/Desktop/checkvt.log
		echo "http has been added, URL is now: ${_LASTCHECKURL}" >> ~/Desktop/checkvt.log
	fi

	# check the last checked URL for / at end
	if [[ "${_LASTCHECKURL}" != *'/' ]] # if last checked URL does not contain / at end, we need to add it
	then
		_LASTCHECKURL+='/'
		echo "The redirect URL did not contain a / at end." >> ~/Desktop/checkvt.log
		echo "Fixed, redirect URL is now: ${_LASTCHECKURL}" >> ~/Desktop/checkvt.log
	fi

	# redirect existed, so we use the last checked URL which is inside the _LASTCHECKURL variable already
	_SHAURL=$(echo -n "${_LASTCHECKURL}" | openssl dgst -sha256)

	# then we combine it with the virus total base URL
	_FINALURL="${_VTBASEURL}${_SHAURL}"

	# then we open the combined final URL
	echo "The redirected final URL was: ${_FINALURL}" >> ~/Desktop/checkvt.log
	open "${_FINALURL}"
fi

echo "######################## Last run on: $(date) ########################" >> ~/Desktop/checkvt.log

#end