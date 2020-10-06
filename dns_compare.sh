#!/bin/bash
#ealmonte32

# set current working directory to folder where script is running from
cd "$(dirname "${0}")"

# set location of log file to inside current working dir
_LOGFILE="$(pwd)/dns_compare.log"

echo "=============================================================================" | tee -a "${_LOGFILE}"

# ask user to enter some URLs
echo "Please enter upto (3) URLs to compare DNS filtering:"
read -p " URL 1: " url1
read -p " URL 2: " url2
read -p " URL 3: " url3
#echo "" | tee -a "${_LOGFILE}"

domain_list="$url1 $url2 $url3" #or have a domain per line in a text file

dns1_ip='1.1.1.2' #cloudflare
dns2_ip='9.9.9.9' #quad9
dns3_ip='208.67.222.222' #opendns
dns4_ip='8.8.8.8' #google

# function to get the average ping
get_ping_avg () {
	pingavg=$(ping -c 1 -t 1.5 "$ip_here" | grep round-trip | awk '{print $4}' | awk -F '/' '{print $1}')
}

echo "" | tee -a "${_LOGFILE}"
echo "The DNS servers we will be using are:" | tee -a "${_LOGFILE}"
echo " CloudFlare: $dns1_ip, Quad9: $dns2_ip, OpenDNS: $dns3_ip, Google: $dns4_ip" | tee -a "${_LOGFILE}"
echo "" | tee -a "${_LOGFILE}"
echo "Today's date:" | tee -a "${_LOGFILE}"
echo " $(date)" | tee -a "${_LOGFILE}"
echo "=============================================================================" | tee -a "${_LOGFILE}"

for domain in ${domain_list} #start looping through domains , each $domain is the source name from domain_list
do
	ip1=$(dig @$dns1_ip +tries=1 +time=2 +short $domain | tail -n1) #ip address lookup using dns server1
	ip2=$(dig @$dns2_ip +tries=1 +time=2 +short $domain | tail -n1) #ip address lookup using dns server2
	ip3=$(dig @$dns3_ip +tries=1 +time=2 +short $domain | tail -n1) #ip address lookup using dns server3
	ip4=$(dig @$dns4_ip +tries=1 +time=2 +short $domain | tail -n1) #ip address lookup using dns server4
		echo "Domain: $domain" | tee -a "${_LOGFILE}"
		echo " IP returned by CloudFlare: $ip1" | tee -a "${_LOGFILE}"
		echo " IP returned by Quad9: $ip2" | tee -a "${_LOGFILE}"
		echo " IP returned by OpenDNS: $ip3" | tee -a "${_LOGFILE}"
		echo " IP returned by Google: $ip4" | tee -a "${_LOGFILE}"
		ip_here="${ip4}" #use google dns for ip since it does not filter it
		get_ping_avg;
		echo " Average ping for $domain: $pingavg ms" | tee -a "${_LOGFILE}"
		if [[ "$ip1" != "$ip2" || "$ip2" != "$ip3" || "$ip3" != "$ip4" ]]
		then
			echo " ** IP Mismatch Found! **" | tee -a "${_LOGFILE}"
			echo " This domain either gets filtered or it has multiple IPs.." | tee -a "${_LOGFILE}"
		fi
		echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" | tee -a "${_LOGFILE}"
		sleep 1; #pause before next one to avoid flooding
done

# give some space between next log entry
echo -e "\n\n\n" | tee -a "${_LOGFILE}"

#end