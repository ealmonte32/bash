#!/bin/bash
clear;

echo -e "\n################ 1 ####################\n"

alphabet_array=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
#index of array(0 1 2 3 4 5 6 7 8 9 .............................25)

plaintext=a
key=2

for i in "${!alphabet_array[@]}"; do
   if [ "${alphabet_array[$i]}" = "${plaintext}" ]; then
	echo "letters matched: $plaintext" 
	echo "index of match: ${i}"; #output value of index that matched value letter
	i=$(expr $i + $key ); #add a an integer of 1 to the index
	echo "added value of key ($key) to index"
	echo "new value of index: ${alphabet_array[i]}" #this output should now be value of array at new index with added integer shifted
   fi
done

echo -e "\n################ 2 ####################\n"

ciphertext=()
plaintext="helloworld"
key=1

for (( x=0; x<${#plaintext}; x++ )); do
echo "current loop= $x"
echo "plaintext= ${plaintext:$x:1}"
  for i in "${!alphabet_array[@]}"; do
    if [ "${plaintext:$x:1}" == "${alphabet_array[$i]}" ]; then
#   if [ "${alphabet_array[$i]}" = "${plaintext}" ]; then
        echo "plaintext entered: $plaintext"
        echo "index of match: ${i}"; #output value of index that matched value letter
        i=$(expr $i + $key ); #add a an integer of 1 to the index
        echo "added value of key ($key) to index"
        echo "new value of index: ${alphabet_array[i]}" #this output should now be value of array at new index with added integer shifted
	echo ""
	ciphertext=("${ciphertext[@]}" "${alphabet_array[i]}")
   fi
  done
done

echo ${ciphertext[@]}

#ALPHABET=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
####index(0 1 2 3 4 5 6 7 8 9 10...........................25)
#declare -a CIPHERTEXT
#PLAINTEXT=testing
#echo "everything in the array: ${ALPHABET[@]}"
#echo "index numbers of array: ${!ALPHABET[@]}"

#VAR=$(echo hello | grep -o . )
#echo -e "Your ciphertext is: $(echo $VAR | tr -d [:space:])\n"
