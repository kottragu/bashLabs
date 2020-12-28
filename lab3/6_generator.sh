#!/bin/bash

while true;
do
	read LINE
	case "$LINE" in
		"TERM")
			kill -TERM $1
			exit 0 ;;
		"+")
			kill -USR1 $1 ;;
		"*")
			kill -USR2 $1 ;;
	esac
done
