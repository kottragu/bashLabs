#!/bin/bash
ppid=0
count=0
art=0
time=0
while read LINE
do
	ppid_tmp=$(echo "$LINE" | grep -Eo "Parent_ProcessID=[0-9]+" | grep -Eo "[0-9]+")
	art_tmp=$(echo "$LINE" | grep -Eo "[0-9]*\.{0,1}[0-9]+$")
	if [[ $ppid != $ppid_tmp && $count != '0' ]]; then
		time=$(echo "scale=7;$art/$count" | bc)
		echo "Average_Sleeping_Children_of_Parent=$ppid is $time" >> 2_5.txt
		count=0
		art=0
	fi
	ppid=$ppid_tmp
	art=$(echo "scale=7; $art+$art_tmp" | bc)
	count=$(echo "scale=0; $count+1" 2>/dev/null | bc)
	echo $LINE >> 2_5.txt
done < 2_4.txt
relation=$(echo "scale=7;$art/$count" | bc)
echo "Average_Sleeping_Children_of_Parent=$ppid is $time" >> 2_5.txt


