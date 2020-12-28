#!/bin/bash

tmp=$(ls /proc | grep -E "^[0-9]+")

for tmp_pid in $tmp
do
	ppid_tmp=$(cat /proc/$tmp_pid/status 2>/dev/null | grep -E "ppid:" | grep -Eo "[0-9]+")
	if [[ ! $ppid_tmp == "" ]]; 
	then 
		sum_exec_runtime=$(cat /proc/$tmp_pid/sched | grep -E "sum_exec_runtime" | grep -Eo "[^[:space:]]+$")
		nr_switches=$(cat /proc/$tmp_pid/sched | grep -E "nr_switches" | grep -Eo "[^[:space:]]+$")
		art=$(echo "scale=5;$sum_tmp/$nr_tmp" | bc)
		
		echo "ProcessId=$tmp_pid : Parent_ProcessID=$ppid_tmp : Average_Running_Time=$art_tmp" >> 2_4.txt
	else
		continue
	fi
done

file_tmp=$(cat 2_4.txt | sort -t':' -nk2.19)
echo "$file_tmp" > 2_4.txt
