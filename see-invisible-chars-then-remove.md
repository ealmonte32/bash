#### This is used when weird characters are messing up the results or outcome of a piped command or a command like curl which returns carriage returns and other chars.

```
emyllalmonte@eambp:~$ echo "$CHECKURL" | LC_ALL=C cat -v
HTTP/1.1 301 Moved Permanently^M
Server: nginx/1.16.1^M
Date: Thu, 20 Aug 2020 02:56:29 GMT^M
Content-Type: text/html; charset=utf-8^M
Connection: close^M
Location: https://alphatermite.com^M
^M
emyllalmonte@eambp:~$ echo "$CHECKURL" | LC_ALL=C cat -v | tr -d '^M'
HTTP/1.1 301 oved Permanently
Server: nginx/1.16.1
Date: Thu, 20 Aug 2020 02:56:29 GT
Content-Type: text/html; charset=utf-8
Connection: close
Location: https://alphatermite.com

emyllalmonte@eambp:~$ TEST=$(echo "$CHECKURL" | LC_ALL=C cat -v | tr -d '^M')
emyllalmonte@eambp:~$ echo "$TEST"
HTTP/1.1 301 oved Permanently
Server: nginx/1.16.1
Date: Thu, 20 Aug 2020 02:56:29 GT
Content-Type: text/html; charset=utf-8
Connection: close
Location: https://alphatermite.com
emyllalmonte@eambp:~$ echo "$TEST" | grep -i location
Location: https://alphatermite.com
emyllalmonte@eambp:~$ echo "$TEST" | grep -i "location"
Location: https://alphatermite.com
emyllalmonte@eambp:~$ echo "$TEST" | grep -i "location" | awk '{print $2}'
https://alphatermite.com
emyllalmonte@eambp:~$ FINALTEST=$(echo "$TEST" | grep -i "location" | awk '{print $2}')
emyllalmonte@eambp:~$ echo "$FINALTEST"
https://alphatermite.com
emyllalmonte@eambp:~$ echo "$FINALTEST"/
https://alphatermite.com/
emyllalmonte@eambp:~$ 
```
