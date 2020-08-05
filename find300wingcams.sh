#!/bin/bash
rm -rf ./300wingcamerasfound.txt; rm -rf ./300wingnoresponse.txt;
for i in {46..249}
do
ping -t 1 -c 1 192.168.30.$i >/dev/null;
if [ $? != 0 ]
then echo 192.168.30.$i >> 300wingnoresponse.txt;
else curl -s --digest --user admin:admin 192.168.30.$i | grep -iq sensor && echo 192.168.30.$i >> 300wingcamerasfound.txt;
fi
done
