#!/bin/bash

TOTAL=0

for i in {1..100}
do
echo "Current total: $i"
TOTAL=$TOTAL
TOTAL=$(expr $i + $TOTAL)
echo "Addition of all: $TOTAL"
done
