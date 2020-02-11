#!/bin/bash
#ealmonte

echo ""
#read option -s means enter silently
read -sp "Enter your password: " PASSENTER
shasum -a 256 <<< $PASSENTER >/tmp/passenter

echo ""
read -sp "Verify your password: " PASSVERIFY
shasum -a 256 <<< $PASSVERIFY >/tmp/passverify

# need to check the difference because checksum will not produce desired exit status
diff /tmp/passenter /tmp/passverify >/dev/null

if [ $? != 0 ]
then
echo -e "\nPasswords dont match."
else
echo -e "\nPasswords match."
fi
rm -f /tmp/passenter /tmp/passverify

#end

