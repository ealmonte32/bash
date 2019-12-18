#!/bin/bash
clear
echo " ================================== "
echo -e "If you want to exit the program, type exit as the domain name.\n"
for i in {1..10}
do
 echo -e "\nThis is search #$i\n"
 read -p "Enter a school domain to search (ex: montclair.edu): " DOMAIN
 if [ "$DOMAIN" == "exit" ]
then
 echo -e "Exiting\n";exit
else 
 echo `curl -s https://who.is/whois/$DOMAIN | grep -A2 "Administrative"`
 echo " ================================== "
fi
done
