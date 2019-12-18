#!/bin/bash

# this is a script for the GUESS ME game, written by Emyll Almonte

# allow user to enter name and present welcome message
echo -e "Welcome to the GUESS ME game.\n"
read -p "Please enter your name: " PLAYER
echo " "
echo -e "Hello $PLAYER, lets begin...\n"
# tell user how they could exit the game if they wish to do so
echo -e "(If you wish to exit the game, type the word exit and press enter)\n"

# generate a random number into a variable called GUESSME
let GUESSME=`echo 100*$RANDOM/32767 | bc -l | awk -F '.' '{print $1}'`
let COUNTER=0

# allow user to enter number between 1 and 100
echo -e "Try to guess which number I am thinking about, its from 1 to 100..\n"
read -p "Enter the number and press enter: " NUMINPUT

# check if user wants to exit the game
if [ "$NUMINPUT" == "exit" ]
then
 echo -e "You chose to exit the game, thanks for playing.\n"
exit

# make sure input is an integer
elif [[ ! "$NUMINPUT" == ^[0-9]+$ ]] || [ $NUMINPUT -ge 101 ] || [ $NUMINPUT -le 0 ]
then
#for debug purposes to know which if statement gave an error, i add that echo line error with section
 echo "(Error, section 1)"
 echo "Sorry, but you did not enter a number between 1 and 100.."
 echo -e "Program will now exit.\n"; exit
fi

# this is the while loop
# it gives you a "higher or lower" hint and asks for another guess until you get it
while [[ "$NUMINPUT" != $GUESSME ]]
do
((COUNTER++))
if [ "$NUMINPUT" == "exit" ]
then
 echo -e "You chose to exit the game, thanks for playing.\n"
exit

elif [[ ! "$NUMINPUT" =~ ^[0-9]+$ ]] || [ $NUMINPUT -ge 101 ] || [ $NUMINPUT -le 0 ]
then
 echo "(Error, section 2)"
 echo "Sorry, but you did not enter a number between 1 and 100.."
 echo -e "Program will now exit.\n"; exit
 elif [ $NUMINPUT -gt $GUESSME ]
   then
    echo -e "(Hint: Try a lower number)\n"
   else
    echo -e "(Hint: Try a higher number)\n"
fi
read -p "Wrong guess, try again: " NUMINPUT
done

if [[ "$NUMINPUT" == $GUESSME && $COUNTER -le 2 ]]
 then
  banner "Correct, Yay!"; exit
 else
  echo -e "Correct, the answer was $GUESSME, and it took you $COUNTER tries.\n"
#creating a record of every game played for record keeping purposes
echo "===================================================================" >> /var/tmp/guessme.txt
echo " " >> /var/tmp/guessme.txt
echo "The name of the player was: $PLAYER" >> /var/tmp/guessme.txt
echo "The date and time of this game was: `date`" >> /var/tmp/guessme.txt
echo "Number of tries were: $COUNTER" >> /var/tmp/guessme.txt
echo " " >> /var/tmp/guessme.txt
fi

