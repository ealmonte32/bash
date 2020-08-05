#!/bin/bash
rm -rf ./100wingcamerasfound.txt; rm -rf ./100wingnoresponse.txt;
for i in {30..249}
do
ping -t 1 -c 1 192.168.1.$i >/dev/null;
if [ $? != 0 ]
then echo 192.168.1.$i >> 100wingnoresponse.txt;
else curl -s --digest --user admin:admin 192.168.1.$i | grep -iq sensor && echo 192.168.1.$i >> 100wingcamerasfound.txt;
fi
done
