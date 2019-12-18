#!/bin/bash
#sample for using case statements

echo -e "(if you want to exit type exit as the fruit name or press ctrl+c)\n"
echo " "
read -p "Type name of a fruit: " MYFRUIT
echo " "

if [ "$MYFRUIT" == "exit" ]
then
exit
fi

case $MYFRUIT in
"apples"|"apple")
 echo -e "$MYFRUIT color is red.\n"
;;
"oranges"|"orange")
 echo -e "$MYFRUIT color is orange.\n"
;;
*)
 echo -e "I don't know that fruit..\n"
;;
esac


#run the program again until ctrl+c or user exit
./casesample.sh
