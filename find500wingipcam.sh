#!/bin/bash
rm -rf ./500wingcamerasfound.txt; rm -rf ./500wingnoresponse.txt;
for i in {10..249}
do
ping -t 1 -c 1 192.168.50.$i >/dev/null;
if [ $? != 0 ]
then echo 192.168.50.$i >> 500wingnoresponse.txt;
else curl -s --digest --user admin:admin http://192.168.50.$i | grep -iq sensor && echo 192.168.50.$i >> 500wingcamerasfound.txt;
fi
done

