#!/bin/bash
rm -rf ./600wingcamerasfound.txt; rm -rf ./600wingnoresponse.txt;
for i in {10..249}
do
ping -t 1 -c 1 192.168.60.$i >/dev/null;
if [ $? != 0 ]
then echo 192.168.60.$i >> 600wingnoresponse.txt;
else curl -s --digest --user admin:admin http://192.168.60.$i | grep -iq sensor && echo 192.168.60.$i >> 600wingcamerasfound.txt;
fi
done
