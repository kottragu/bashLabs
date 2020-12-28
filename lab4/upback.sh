#!/bin/bash
directory="/home/`whoami`"
if [[ -d "$directory/restore" ]]
then
	rmdir "$directory/restore"
fi

mkdir "$directory/restore"

backup_prev=$(ls $dir | grep -E "^Backup_" | sort -n | tail -1)
date_time_backup_prev=$( echo "$backup_prev" | sed "s/Backup_//" )

if [[ -z "$backup_prev" ]]
then
	echo "Нема бекапов (лаба4 по осям)"
	exit
fi

for line in $( ls "$directory/$backup_prev" | grep -Ev "\-[0-9]{4}-[0-9]{2}-[0-9]{2}$" )
do
	cp "$directory/$backup_prev/$line" "$directory/restore/$line"
done
