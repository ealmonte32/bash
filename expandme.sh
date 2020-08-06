#!/bin/bash
#ealmonte

#################################################################################
# just a basic automated script that waits for file to be inside the dir
# then uses sed to add a space in between every character
# just to practice having something running that executes upon action
# just like online services that you upload something and it converts it for you
##################################################################################

DIR=~/Desktop/Expandme
PREDIR=~/Desktop/Pre-Expandme
POSTDIR=~/Desktop/Post-Expandme

echo "Expandme is running..."

while true; do
if [[ "$(ls -A ${DIR})" ]]
then
 cp "${DIR}"/*.* "${PREDIR}" >/dev/null 2>&1 ; sleep 1
 sed -i '' 's/./& /g' "${DIR}"/*.* >/dev/null 2>&1 ; sleep 1
 cp "${DIR}"/*.* "${POSTDIR}" >/dev/null 2>&1 ; sleep 1
 rm -f "${DIR}"/*.* >/dev/null 2>&1 ; sleep 1
 echo -e "Processed a file on $(date) \n"
else
 echo "Waiting for file to process..."; sleep 2
fi
done

#end
