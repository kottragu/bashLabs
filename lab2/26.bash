#!/bin/bash

max_mem=0
pid_result=0

for pid in $( ps -e | tail -n +2 | awk '{ print $1 }' )
do
	this_mem=`cat "/proc/"$pid"/statm" | awk '{ print $2 }'`
	if [[ $max_mem < $this_mem ]]
	then
		pid_result=$pid
		max_mem=$this_mem
	fi
done 

echo "result pid:" $pid_result
