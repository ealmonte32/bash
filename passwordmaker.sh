#!/bin/bash
#ealmonte

alphabet_array=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
ciphertext=()

# function to encrypt
function encrypt {
echo -e "\nPlease enter a number from 0-25 as the key for encryption, then press enter: "
read key

echo "Please enter the text you would like to encrypt, then press enter: "
read plaintext

if [[ "$plaintext" != "" ]]
then
for (( x=0; x<${#plaintext}; x++ )); do
 for i in "${!alphabet_array[@]}"; do
  if [ "${plaintext:$x:1}" == "${alphabet_array[$i]}" ]; then
        i=$(expr $i + $key ); #add an integer of value of key to the index
	ciphertext=("${ciphertext[@]}" "${alphabet_array[i]}")
  fi
 done
done

finalcipher=$(echo ${ciphertext[@]} | tr -d [:space:])
echo -e "\nYour Ciphertext is: $finalcipher"

else
 echo "(Error) You did not enter text to encrypt."
 echo "Program will now exit."; exit
fi

}


# function to decrypt
function decrypt {
echo "Decrypted text: "
}


# main selection function
function main {
echo "(Menu)"
echo "Which cryptographic function would you like to use?"
echo "Press 1 to Encrypt text."
echo "Press 2 to Decrypt text."
read -n 1 -r SELECTION

case $SELECTION in
    1 ) encrypt
        ;;
    2 ) decrypt
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
