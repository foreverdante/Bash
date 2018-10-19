#!/bin/bash
#Created By: J.Medlock
#Created On: 09.21.2018

file=$1

while IFS="," read -r phone type blank name end; do
	phoneReturn=$(printf "$phone" | sed 's/^\"\([0-9]\{3\}\)\([0-9]\{3\}\)\([0-9]\{4\}\)/\(\1\)\2-\3/' | cut -d'"' -f1)
	nameReturn=$(printf "$name" | cut -d'"' -f2)

	if [[ $nameReturn == " " ]] ; then
		echo "$phoneReturn -- Unassigned" >> did_list.csv
	else
		echo "$phoneReturn -- $nameReturn" >> did_list.csv
	fi

	#echo "$phoneReturn -- $nameReturn" >> did.csv
done < "$file"
