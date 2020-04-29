#!/bin/bash
#ealmonte32

#input="springer_books_links.txt"
input=links.txt

while IFS='' read -r line
do
curl -O $line
done <"$input"

#end
#remember text file may have to be saved from BBEdit with line breaks as Windows CRLF and then
#the command to remove the illegal characters:
#tr -d '\r' < originalfile.txt > newfile.txt
