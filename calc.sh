#!/bin/bash
#ealmonte

clear
echo " "
read -p "enter a number: " NUM1
read -p "do you want to add, sub, mult, or div? " CALC
read -p "enter another number to be calculated with first number: " NUM2

if [ "$CALC" == "add" ]
then
CALC="+"
elif [ "$CALC" == "sub" ]
then
CALC="-"
elif [ "$CALC" == "mult" ]
then
CALC="*"
elif [ "$CALC" == "div" ]
then
CALC="/"
fi

echo "The calculation of $NUM1 $CALC $NUM2 is: `expr $NUM1 "\$CALC" $NUM2`"
#end
