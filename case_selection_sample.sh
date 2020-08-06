#!/bin/bash
#ealmonte

#sample script to add and delete items to an array inside a file interactively

declare -a ARRAY

# functions
read_array_list()
{
IFS=$'\n' read -d '' -r -a ARRAY < ~/array_list.txt
}

press_enter()
{
    echo -en "\nPress Enter to return to main menu..."
    read
    clear
}

add_element()
{
    echo -n "Enter a word to add to the array and press enter: "
    read entereditem
    echo "Adding entered item to array..."
    CHECK=$(printf '%s\n' "${ARRAY[@]}" | grep "$entereditem$") #adding the dollar sign at end makes sure that it only finds the exact match
    if [[ -z "$CHECK" ]] #if the entered word was not found in the list - continue to add it
    then
	echo "$entereditem" >> ~/array_list.txt
    	echo "Done."
    	echo -en "Would you like to enter another item? (Press y for yes or any other key for no)\n"
    	read -n 1 enteranother
    	case $enteranother in
		y ) clear; add_element ;;
		* ) clear ;;
    	esac
    else #if word was found in array already - throw error
	echo "Error, that word is already on the array list."
	echo -en "Would you like to try again? (Press y for yes or any other key for no)\n"
	read -n 1 tryagain
        case $tryagain in
                y ) clear; add_element ;;
                * ) clear ;;
        esac
    fi
}

remove_element()
{
    echo "Elements in array:"
    printf '%s\n' "${ARRAY[@]}"
    echo ""
    echo -n "Enter the exact name of the item in the array you would like to remove: "
    read entereditem
    echo "Removing entered item from array..."
    CHECK=$(printf '%s\n' "${ARRAY[@]}" | grep "$entereditem$") #adding the dollar sign at end makes sure that it only finds the exact match
    if [[ -z "$CHECK" ]] #if the entered word was not found in the list
    then
	echo "That item was not found on the array, try again.";
    else
	ARRAY=( "${ARRAY[@]/$entereditem/}" )
	printf '%s\n' "${ARRAY[@]}" > ~/array_list.txt
    echo "Done."
    fi
}

# clear current screen/console
clear;

selection=""
until [ "$selection" = "0" ]; do
echo "
========================
========MAIN MENU=======
========================
1 - Display the contents of the array
2 - Add items to the array
3 - Remove items from the array

0 - Exit program
"

echo -n "Enter selection and press enter: "
read selection
echo ""
case $selection in
   1 ) clear; read_array_list ; echo -e "Array contains: \n"; printf '%s\n' "${ARRAY[@]}" ; press_enter ;;
   2 ) clear; add_element ;;
   3 ) clear; read_array_list ; remove_element ; press_enter ;;
   0 ) exit ;;
   * ) echo "Incorrect selection, selection must be 1,2,3 or 0."; press_enter
esac
done

# end
