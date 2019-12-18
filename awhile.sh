#!/bin/bash

# this file will check for the existence of a file
# -f means , does a file exist, so ! -f means  while it doesnt exist..

while [ ! -f /home/ec2-user/STOP ]
do
 echo "The file is NOT there yet"
 sleep 3
done
banner Yay, file there!
