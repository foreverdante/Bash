#!/bin/bash
#Created On: 10.27.15
for U in $(lastlog | grep -v "Never logged in" | awk '{print $1}' | tail -n +2)
do
	NOW=$(date +%s)
	USR=$(lastlog | grep -v 'Never logged in' | awk '{print $1, ":", $4, $5, $8}' | grep $U)
	USRDATE=$(echo $USR | cut -d":" -f2)
	(( USRDATE = $(date --date "$USRDATE" +%s) / 86400 ))
	(( NOW = NOW / 86400 ))
	(( DAYS = NOW - USRDATE ))
	echo "The user $U: logged in $DAYS days ago"
done
