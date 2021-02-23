#!/bin/bash

>result.txt

for pid in $( ps -e | tail -n +2 | awk '{ print $1 }')
do
	status="/proc/"$pid"/status"
	sched="/proc/"$pid"/sched"
	art=0
	ppid=`grep "PPid" $status | grep -o "[0-9]\+"`
	ser=`grep "se.sum_exec_runtime" $sched | awk '{ print $3 }'`
	ns=`grep "nr_switches" $sched | awk '{ print $3 }'`
	
	if [[ ! -z $ser && ! -z $ns ]]
	then
		art=$( echo "scale=4; $ser/$ns" | bc )
	fi
	echo "ProcessID=$pid ParentProcessID=$ppid AvarageRunningTime=$art" >> result.txt
done
echo `sort -n --key=2 "result.txt"` > result2_4.txt

