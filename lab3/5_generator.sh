#!/bin/bash

mkfifo pipe

while true; do
	read LINE;
	echo $LINE > pipe
done
