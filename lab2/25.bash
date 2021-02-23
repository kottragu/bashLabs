#!/bin/bash

> result2_5.txt

prev_ppid=1
count=0
art_sum=0

for line in $"result2_4.txt"
do
	ppid=`awk '{ print $2 }' <<< $line`
	art=`awk '{ print $3 }' <<< $line`
	
	if [[ $ppid != $prev_ppid ]]
	then
		echo "Avarage_Slipping_Children_OF_ParentPID=$prev_ppid : " $(echo "scale=4; $art_sum/$count" | bc) >> result2_5.txt
		prev_ppid=$ppid
		art_sum=0
		count=0
	fi
	art_sum+=$(echo "$art_sum+$art" | bc)
	count=$(( $count+1 ))
	echo $line >> result2_5.txt
done

