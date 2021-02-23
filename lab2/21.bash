ps -e | wc -l > 2.1.txt
ps -e | awk '{print $1 ":" $4}' >> 2.1.txt