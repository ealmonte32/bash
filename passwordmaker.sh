#!/bin/bash
#ealmonte

alphabet_array=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
#array index #=(0 1 2 3 4 5 6 7 8 9 10...........................25)
ciphertext=()
decryptedtext=()

# function to encrypt
function encrypt {
echo -e "\nPlease enter a number from 1-25 as the key for encryption, then press enter: "
read key

if [[ $key -lt 1 ]] || [[ $key -gt 25 ]]; then
	echo "(Error) You entered an incorrect number."
	read -p "Would you like to try again? (y/n): " -n 1 -r -s tryagain
	if [ "$tryagain" != "y" ]; then
	 echo -e "Goodbye.\n"; exit
	else
	 clear;encrypt;
	fi
	exit;
fi

echo "Please enter the text you would like to encrypt, then press enter: "
read plaintext

if [[ "$plaintext" != "" ]]; then #if value of plaintext is not empty run the commands below

for (( x=0; x<${#plaintext}; x++ )); do #this for loop will run upto the length of characters in plaintext
 for i in "${!alphabet_array[@]}"; do #this for loop runs and checks every index of the alphabet array
  if [ "${plaintext:$x:1}" == "${alphabet_array[$i]}" ]; then #if the character is found in the current index of array
	#echo "index of this loop = $i" #comment or uncomment for debugging
	#echo "alphabet value of current i = ${alphabet_array[$i]}" #comment or uncomment for debugging
	i=$(expr $i + $key ); #add an integer of value of key to the index
	if [ $i -gt 25 ]; then
	i=$(expr $i - 26 )
	fi
	#echo "value of i plus key is $i" #comment or uncomment for debugging
	ciphertext=("${ciphertext[@]}" "${alphabet_array[i]}") #add each character to the new ciphertext array
  fi
        #echo "loop x = $x" #comment or uncomment for debugging
        #echo "array value of x = ${plaintext:$x:1}" #comment or uncomment for debugging
 done
done

#echo "length of plaintext = ${#plaintext}" #comment or uncomment for debugging

finalcipher=$(echo ${ciphertext[@]} | tr -d [:space:]) #this is done to retrieve every ciphered character and remove the space
echo -e "\nYour Ciphertext is: $finalcipher"

else #if the user did not enter anything for plaintext, throw error and exit program
 echo "(Error) You did not enter text to encrypt."
 echo "Program will now exit."; exit
fi

}


# function to decrypt
function decrypt {

echo -e "\nPlease enter the number key (1-25) that was used for encryption, then press enter: "
read key

if [[ $key -lt 1 ]] || [[ $key -gt 25 ]]; then
	echo "(Error) You entered an incorrect number."
	read -p "Would you like to try again? (y/n): " -n 1 -r -s tryagain
	if [ "$tryagain" != "y" ]; then
	 echo -e "Goodbye.\n"; exit
	else
	 clear;decrypt;
	fi
	exit;
fi

echo "Please enter the ciphertext you would like to decrypt, then press enter: "
read encryptedtext

if [[ "$encryptedtext" != "" ]]; then #if value of encryptedtext is not empty run the commands below

for (( x=0; x<${#encryptedtext}; x++ )); do #this for loop will run upto the length of characters in encryptedtext
 for i in "${!alphabet_array[@]}"; do #this for loop runs and checks every index of the alphabet array
  if [ "${encryptedtext:$x:1}" == "${alphabet_array[$i]}" ]; then #if the character is found in the current index of array
	i=$(expr $i - $key ); #subtract an integer of value of key to the index
	if [ $i -lt 0 ]; then
	i=$(expr $i + 26 )
	fi
	decryptedtext=("${decryptedtext[@]}" "${alphabet_array[i]}") #add each character to the new decryptedtext array
  fi
 done
done

finaldecrypted=$(echo ${decryptedtext[@]} | tr -d [:space:]) #this is done to retrieve every ciphered character and remove the space
echo -e "\nYour Decrypted text is: $finaldecrypted"

else #if the user did not enter anything for encryptedtext, throw error and exit program
 echo "(Error) You did not enter text to decrypt."
 echo "Program will now exit."; exit
fi

}


# main selection function
function main {
echo "(Menu)"
echo "Which cryptographic function would you like to use?"
echo "Press 1 to Encrypt text."
echo "Press 2 to Decrypt text."
read -n 1 -r SELECTION

case $SELECTION in
    1 ) encrypt;sleep 1;
        ;;
    2 ) decrypt;sleep 1;
        ;;
    * ) echo -e "\n(Error) Sorry, but you did not enter a number selection between 1 and 2."
	echo -e "Program will now exit..\n";exit
	;;
esac
}


# starting screen for users, so lets clear it before program starts
clear;
echo "*~~[Welcome to Text Cryptographer]~~*"
echo -e "This program will encrypt or decrypt your text input according to your key selection.\n"
main;

# end
