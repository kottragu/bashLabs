#!/bin/bash

>bs.txt
>as.txt
>temp.txt
>result2_7.txt
max=0
max_pid=0
delta=0

for pid in $( ps -e | tail -n +2 | awk '{ print $1 }' )
do
	echo "$pid " `cat "/proc/"$pid"/io" | grep "read_bytes" | awk '{ print $2 }'` >> bs.txt
done

sleep 5s

for pid in $( ps -e | tail -n +2 | awk '{ print $1 }' )
do
	echo "$pid " `cat "/proc/"$pid"/io" | grep "read_bytes" | awk '{ print $2 }'` >> as.txt
done

cat "as.txt" |
while read line
do
	pid=`awk '{ print $1 }' <<< $line`
	wb=`awk '{ print $2 }' <<< $line`
	prev_wb=`cat "bs.txt" | awk -v id="$pid" '{ if ($1 == id ) print $2 }'`
	#echo "$pid : $wb : $prev_wb"
	delta=$(($wb-$prev_wb))
	echo "$pid : $delta" >> temp.txt

done

cat "temp.txt" | sort -n --key=3 | tail -n 3 
