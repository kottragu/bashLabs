#!/bin/bash

if [[ $# -ne 1 ]]
then	
	echo "надо 1"
	exit 1
fi

trash=`pwd`/.trash
trash_log=`pwd`/.trash.log 

if [[ ! -d $trash ]]
then
	echo "мусорки нема"
	exit 1
fi

if [[ ! -e $trash_log ]]
then
	echo ".trash.log нема"
	exit 1
fi

if [[ $(`grep -E "$1 " $trash_log`) == "" ]]
then
	echo "этот файл не удаляли"
	exit 1
fi


check_and_create() {
	if [[ -f $file_path ]]
	then
		read -p "Файл $file_path уже есть, введите новое имя: " name <&1
		ln "$3" "$1/$new_name"
		rm "$3"
	else
		ln "$3" "$1/$2"
		rm "$3"
	fi

}

echo "$(`grep -E "/$1" $trash_log`)" |
while read line;
do
	file_path=$(echo "$line" | awk `{print $1}` )
	file_reference=$(echo "$line" | awk `{print $2}` )
	read -p "Надо ли извлечь $file_path (y/n)?" rez <&1

	case $rez in
		"Y" | "y")
			way=$(echo "$file_path" | awk -F "/$1" `{print $1}` )
			if [[ ! -d $way ]]
			then
				echo "Директории $way нема, файл будет восстановлен в $HOME"
				check_and_create() $HOME $1 $file_reference
			else
				check_and_create() $way $1 $file_reference

			fi
			;;
		*) continue ;;
	esac
done




