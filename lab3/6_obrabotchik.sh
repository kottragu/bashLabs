#!/bin/bash

result=1
op="+"

TERM()
{
	echo "Finish"
	exit 0
}

SIGUSR1()
{
	command="+"
}

SIGUSR2()
{
	command="*"
}

trap 'TERM' SIGTERM
trap 'SIGUSR1' USR1
trap 'SIG2' USR2

while true;
do
	case "$op" in
		"+") result=$(($result + 2)) ;;
		"*") result=$(($result * 2)) ;;
	esac
	echo $result
	sleep 1
done
