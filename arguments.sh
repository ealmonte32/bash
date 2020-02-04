#!/bin/bash
#ealmonte

echo -e "#####################\n$(date "+# DATE: %m/%d/%Y  #%n# TIME: %r #")\n#####################"

echo "Argument 1 is $1
echo "Argument 2 is $2
echo "Argument 3 is $3
echo "Argument 4 is $4
echo "Argument 5 is $5
echo "All of my arguments are $*
echo "the program I just ran is called $0 , but it could also return the exit status of command.."
echo "the number of arguments I gave was $#"
echo "the process ID of this script was $$"

#end
