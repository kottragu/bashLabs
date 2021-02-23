#!/bin/bash

> report.log

arr=()
step=0
while [[ true ]]
do
	arr+=(1 2 3 4 5 6 7 8 9)
	let step+=1
	if [[ $(($step % 100000)) -eq 0 ]]
	then
		let step=0
		echo "${#arr[@]} " >> report.log
	fi
done