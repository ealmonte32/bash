#!/bin/bash
#ealmonte
two basic examples

# this will check for the existence of a file
# -f means , does a file exist, so ! -f means  while it doesnt exist..

while [ ! -f /folder/STOP ]
do
 echo "The file is NOT there yet"
 sleep 3
done
# then we can just send a touch /folder/STOP to stop the script


## this will echo every number until reaching the specified one
while [ $A -lt 10000 ]
 do
 (( A=A+1 ))
 echo $A
done

#end
