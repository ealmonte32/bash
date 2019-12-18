#!/bin/bash

echo Hello, it is `date`.

echo Argument 1 is $1
echo Argument 2 is $2
echo Argument 3 is $3
echo Argument 4 is $4
echo Argument 5 is $5
echo All of my arguments are $*
echo the program I just ran is called $0
echo the number of arguments I gave was $#
echo the process ID of this script was $$

sleep 3
echo Test after 3 seconds
