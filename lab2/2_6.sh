#!/bin/bash
echo "%7s %7s\n" /proc top

max_mem=-1
max_pid=0
all_pid=$(ls /proc | grep -Eo "^[0-9]+$")

for pid in $all_pid
do
	mem=$(cat /proc/$pid/status 2>/dev/null | grep "VmRSS:" | grep -Eo "[0-9]* kB$" | grep -Eo "^[0-9]*")
	if [[ $mem != "" ]]; then
		if (( $max_mem < $mem )); then
			max_mem=$mem
			max_pid=$pid
fi
fi
done
echo "%7s %7s\n" $max_pid $(top -b -n 1 -o %MEM | sed '8!d' | awk '{print $1}')
