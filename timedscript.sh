#!/bin/bash
#ealmonte32

#timed responses
#ask the question then wait 3 seconds for answer before moving to next

echo -e "\nThis quiz requires you to type the answer in exact words and press the enter/return key when done."
read -p "Are you ready? If yes, press enter/return to continue..."
echo ""

echo "Question #1: What is the capitol of New Jersey?"
echo -e "\nHurry up, you have 5 seconds!"
read -t 5 Q1ANS
if [ "$Q1ANS" == "trenton" ]
then
    echo "Correct!"
else
    echo -e "\nSorry, you took too long to answer or got the question wrong!"
fi

#end
