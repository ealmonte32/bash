#!/bin/bash
rm -rf ./400wingcamerasfound.txt; rm -rf ./400wingnoresponse.txt;
for i in {10..249}
do
ping -t 1 -c 1 192.168.40.$i >/dev/null;
if [ $? != 0 ]
then echo 192.168.40.$i >> 400wingnoresponse.txt; echo "current ip being pinged is 192.168.40.$i";
else curl -s --digest --user admin:admin 192.168.40.$i | grep -iq sensor && echo 192.168.40.$i >> 400wingcamerasfound.txt;
fi
done
