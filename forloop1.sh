#!/bin/bash
#ealmonte

#trying to test gauss calculation with minimal # of iterations

LOW=49
HIGH=51
TOTAL=0

for i in {1..50}
do
 TOTAL=$(expr $TOTAL + $LOW + $HIGH)
 echo "Current iteration is $i"
 echo "current LOW is $LOW"
 LOW=$(expr $LOW - 1)
 echo "current HIGH is $HIGH"
 HIGH=$(expr $HIGH + 1)
 echo "Total is $TOTAL"
done
