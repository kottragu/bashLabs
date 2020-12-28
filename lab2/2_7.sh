#!/bin/bash
all_pid=$(ls /proc | grep -Eo "^[0-9]+$")

for pid in $all_pid
do
	echo $pid" "$(cat /proc/$pid/io 2>/dev/null | grep "read_bytes" | awk '{print $2}') >> bsleep.txt
done

sleep 1m

for pid in $all_pid
do
	echo $pid" "$(cat /proc/$pid/io 2>/dev/null | grep "read_bytes" | awk '{print $2}') >> asleep.txt
done
cat asleep.txt | while read LINE
do
	pid_tmp=$(echo $LINE | awk '{print $1}')
	adata=$(echo $LINE | awk '{print $2}')
	bdata=$(cat bsleep.txt| grep -E "$pid" | awk '{print $2}')
	if [[ $bdata == "" ]]; 
	then 
		continue; 
	fi
	
	diff=$(echo "$adata-$bdata" | bc)
	com=$(ps -q $pid_tmp -o comm=)
	echo "$pid_tmp:$com:$diff" >> tmp.txt
done
cat tmp.txt | sort -t":" -nrk3 | head -3
rm tmp.txt bsleep.txt asleep.txt
