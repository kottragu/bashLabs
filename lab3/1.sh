#!bin/bash
mydate=`(date +%d-%m-%Y\ %H:%M:%S)`

(mkdir test 2>/dev/null) && 
(echo "catalog test was created successfully" > report) &&
(touch test/"$mydate".txt)

(ping "www.http://www.net_nikogo.ru" 2>/dev/null) || 
(echo "`(date +%d-%m-%Y\ %H:%M:%S)`" + "Da_net_tut_nikogo" >> report)
