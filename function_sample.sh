#!/bin/bash
#ealmonte32

#define functions here

function home_space {
    # Only the superuser can get this information
    if [ "$(id -u)" = "0" ]; then
        echo "<h2>Home directory space by user</h2>"
        echo "<pre>"
        echo "Bytes Directory"
            du -s /home/* | sort -nr
        echo "</pre>"
    fi

} #end of home_space



#can write some code here and then call the functions from here



