#!/bin/bash

home_path="/home/`whoami`"
backup_prev=$(ls "$home_path" | grep -E "^Backup_" | sort -n | tail -1)
date_time_now=$(date +"%Y-%m-%d")
date_time_now_sec=$(date -d "$date_time_now" +"%s")
date_time_backup_prev=$(echo "$backup_prev" | sed "s/Backup_//" )
date_time_backup_prev_sec=$(date -d "$date_time_backup_prev" +"%s")
time_difference=$(echo "(${date_time_now_sec} - ${date_time_backup_prev_sec}) / (3600 * 24) " | bc)

if [[ ! -d "$home_path/source" ]]
then
	echo "Source нема"
	exit 1
fi


if [[ ! -e "$home_path/backup-report" ]]
then
	touch "$home_path/backup-report"
fi



if  [[ "$time_difference" -ge 7 ]] || [[ "$backup_prev" == "" ]]
then
	mkdir "$home_path/Backup_${date_time_now}"
	for LINE in $(ls "$home_path/source")
	do
		cp "$home_path/source/$LINE" "$home_path/Backup_${date_time_now}"
	done
	echo -e "Имя: Backup_${date_time_now} \n Дата: ${date_time_now} \n Файлы: $(ls | tr '\n' ' ')\n" >> "$home_path/backup-report"

else
	for LINE in $(ls "$home_path/source")
	do
		if [[ ! -f "$home_path/$backup_prev/$LINE" ]]
		then
			cp "$home_path/source/$line" "$home_path/$backup_prev"
			echo "Cкопирован новый файл: $line" >> "$home_path/backup-report"
		else
			new=$(wc -c "$home_path/source/$LINE" | awk '{print $1}')
			old=$(wc -c "$home_path/$backup_prev/$LINE" | awk '{print $1}')
			if [[ "$new" -ne "$old" ]]
			then
				mv "$home_path/$backup_prev/$LINE" "$home_path/$backup_prev/$line-${date_time_now}"
				echo "Изменён: $LINE -> $line-${date_time_now}" >> "$home_path/backup-report"
				cp "$home_path/source/$line" "$home_path/$backup_prev/$LINE"
			fi
		fi
	done
fi
