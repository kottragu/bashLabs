#!/bin/bash

for (( i=0; i < $1; i++ ))
do
	bash newmem.bash $2
	sleep 1s
done