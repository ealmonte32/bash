#!/bin/bash
#ealmonte

alphabet_array=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
#array index #=(0 1 2 3 4 5 6 7 8 9 10...........................25)
decryptedtext=()
alldecrypted=()

# function to decrypt
function decrypt {
sleep 0.5
echo ""
echo "Please enter the ciphertext you would like to brute-force, then press enter: "
read encryptedtext


if [[ "$encryptedtext" != "" ]] && ! [[ "$encryptedtext" =~ [0-9] ]] && [[ "$encryptedtext" =~ ^[a-z]+$ ]]; then

key=0
for (( brute=0; brute<25; brute++ )); do
(( key++ ))
   for (( x=0; x<${#encryptedtext}; x++ )); do #this for loop will run upto the length of characters in encryptedtext
    for i in "${!alphabet_array[@]}"; do #this for loop runs and checks every index of the alphabet array
      if [ "${encryptedtext:$x:1}" == "${alphabet_array[$i]}" ]; then #if the character is found in the current index of array
	i=$(expr $i + $key )
	if [ $i -gt 25 ]; then
	i=$(expr $i - 26 )
	fi
	#echo "Found match: ${alphabet_array[i]}"
	decryptedtext=("${decryptedtext[@]}" "${alphabet_array[i]}") #add each character to the new decryptedtext array
      fi
    done
   done #after this for loop, example encryptedtext abc has decryptedtext as (b c d)
   finaldecrypted="$(echo ${decryptedtext[@]} | tr -d [:space:])"
   #echo ${decryptedtext[@]}
   alldecrypted=("${alldecrypted[@]}" "$(echo $finaldecrypted)")
   unset decryptedtext
#echo "brute is up to loop # $brute"
#echo "key is up to # $key"
done

echo -e "\nHere are all the possible combinations of your ciphertext with shifting through every letter:\n"
echo "${alldecrypted[@]}"

else #if the user did not enter anything for encryptedtext, throw error and exit program
 echo "(Error) You did not enter alphabetic-only text to brute-force."
 echo "Program will now exit."; exit
fi

}

# main selection function
function main {
echo "(Menu)"
echo "Program is ready for alphabetic-only ciphertext attack, do you want to continue?"
echo "Press 1 to continue.."
echo "Press any other key to exit.."
echo ""
read -n 1 -s -r SELECTION

case $SELECTION in
    1 ) decrypt;
        ;;
    * ) echo -e "Program will now exit..\n";exit
	;;
esac
}

# starting screen for users, so lets clear it before program starts
clear;
echo "*~~~[Welcome to Cipherbrute]~~~*"
echo "Cipherbrute uses an alphabet-based shift cipher decryption method."
echo -e "The program will accept the ciphertext input and produce 25 possible plaintext values.\n"
main;

# end
