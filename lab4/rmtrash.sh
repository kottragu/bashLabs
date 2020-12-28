#!/bin/bash

if [[ $# -ne 1 ]]
then	
	echo "надо 1"
	exit
fi

if [[ ! -f $1 ]]
then
	echo "Файла нема"
	exit
fi

directory=`pwd`

if [[ ! -e "$directory/.trash" ]]
then
    mkdir $directory/.trash
fi

if [[ ! -e "$directory/.trash.log" ]]
then
	echo 1 > "$directory/.trash.log"
fi

if [[ ! -e "$directory/.counter.log" ]]
then
	echo 1 > "$directory/.counter.log"
fi

number=$(`cat "$directory/.counter.log"`)
ln "$directory/$1" "$directory/.trash/$number"
tmp_num=number
let number=number+1
echo "$number">"$directory/.counter.log"

echo "$1 $tmp_num" > "$directory/.trash.log"


