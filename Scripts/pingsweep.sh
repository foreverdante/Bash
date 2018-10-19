#!/bin/bash
#Created By: J.Medlock
#Created On: 06.15.2016

read -p "Do you want to do a single ping or a group ping?(s,g) " answer

if $answer == [sS] ; then
	read -p "Please enter an ip address to ping: " ping1
	if $ping1 == *.*.*.* ; then
		ping -c4 $ping1
	else
		echo "Ut-oh, something went wrong!"
	fi
elif $answer == [gG]
	read -p "Please enter a number to start from: " starting
	read -p "Please enter a number to end with: " ending
	read -p "Please enter a subnet: " subnet
	read -p "Please enter the last number of the ip you want to scan for: " final
	for i in 10.{$starting..$ending}.$subnet.$final ; do
		if ping -c1 -w1 $i &> /dev/null ; then
			echo $i is up 
		else
			echo $i is down
		fi
	done
else
	echo "Something went wrong!"
	echo "Terminating"
fi
