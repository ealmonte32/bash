#!/bin/bash
clear;
echo -e "\n################ 1 ####################\n"

foo=testing
for (( x=0; x<${#foo}; x++ )); do
  echo "${foo:$x:1}"
done

for i in ${foo[@]}; do
echo "${i}"
done

echo -e "\n################ 2 ####################\n"

my_array=(a b c d e f g h i j k)
value=f

for i in "${!my_array[@]}"; do
   if [[ "${my_array[$i]}" = "${value}" ]]; then
	echo "${i}"; #output value of index that matched value letter
	i=$(expr $i + 1 ); #add a an integer of 1 to the index
	echo "${my_array[i]}" #this output should now be value of array at new index with added integer shifted
   fi
done

echo -e "\n################ 3 ####################\n"

ALPHABET=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
####index(0 1 2 3 4 5 6 7 8 9 10...........................25)
declare -a CIPHERTEXT
PLAINTEXT=testing
echo "the values of index: ${ALPHABET[@]}"
echo "the index number: ${!ALPHABET[@]}"

VAR=$(echo hello | grep -o . )
echo -e "Your ciphertext is: $(echo $VAR | tr -d [:space:])\n"
