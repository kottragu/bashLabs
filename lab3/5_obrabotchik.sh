#!/bin/bash

op="+"
result=1
(tail -f pipe) | 
while true;
do
	read LINE
	case $LINE in
		"QUIT") killall tail
			kill pipe
			exit 0 ;;
		"+") op="+" ;;
		"*") op="*" ;;
		[0-9]) case $op in
			"+") result=(($result + $LINE)) 
			echo $result ;;
			"*") result=(($result * $LINE)) 
			echo $result ;;
		*) killall tail
		echo "BAN"
		kill pipe
		exit 1 ;;
	esac
done
