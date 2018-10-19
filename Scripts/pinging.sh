#!/usr/bin/bash
#Created By: J.Medlock
#Created On: 2016.12.29

currentTime=$(date +"%b %d %I:%M:%S")

computerInfo(){
		#Pings computer to see if the target is communicating with network
		count=$(ping -c 1 $target | grep time* | wc -l )
		#Checks NetBIOS for computer MAC address
		MACinfo=$(nmblookup -A $target | grep MAC | tr A-Z a-z | sed 's/-/:/g')
		#Does a grep of nmap to search for computer name
		compname=$(sudo nmap -d -v -O $target | grep Scanning | awk -F' ' '{print $2}' | egrep '^[0-9]{3}' | awk -F'.' '{print $1}')
		#Does a grep of nmap to parse error.log for computers uptime
		uptime=$(sudo nmap -d -v -O $target 1&>/home/jbmedlock/Documents/error.log | grep since > /home/jbmedlock/Documents/error.log)
		#Parses error.log for Uptime and uses awk to retrieve uptime
		newtime=$(grep Uptime /home/jbmedlock/Documents/error.log | awk -F':' '{print $2}' | cut -d' ' -f1,2)
}

computerName(){
	read -p "Please enter the computer name: " computer
	# Checks computername against valid user input
	if [[ $computer =~  ^[0-9]{1,3}\-[A-Za-z0-9]{1,7} ]] ; then
			count=$(ping -c 1 $computer | grep time* | wc -l )
			# Users nmblookup to find MAC Address of computer
			MACinfo=$(nmblookup -A $computer | grep MAC | tr A-Z a-z | sed 's/-/:/g')
			# Finding NetBIOS name for computer
			compname=$(nmblookup -A $computer | awk -F'<' '{print $1}' | sed -n 4p)
			uptime=$(sudo nmap -d -v -O $computer 1&>/home/jbmedlock/Documents/error.log | grep since > /home/jbmedlock/Documents/error.log)
			# Displays current uptime in decimal format
			newtime=$(grep Uptime /home/jbmedlock/Documents/error.log | awk -F':' '{print $2}' | cut -d' ' -f1,2)
			# If there is no ping response, kill the script
			if [ $count -eq 1 ] ; then
				echo $currentTime
				echo "Host is not Alive! Try again later..."
				exit 1
			else
				echo $currentTime
				echo "Yes! Host is Alive!"
				echo $MACinfo
				echo "Computer name: " $compname
				echo "Uptime is:$newtime days"
			fi
	fi
}

function ip(){
	read -p "Please enter an IP to check: " target
	if [[ $target =~  ^[1-9][0-9]{,2}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] ; then
			computerInfo
			if [ $count -eq 1 ] ; then
				echo $currentTime
				echo "Host is not Alive! Try again later..."
			else
				echo $currentTime
				echo "Yes! Host is Alive!"
				echo $MACinfo
				echo "Computer name: " $compname
				echo "Uptime is:$newtime days"
			fi
	else
		echo "Please make sure IP address is in {*.*.*.*} format"
	fi
}

function Main(){
	read -p "Would you like to search by [C]omputer name or [I]P address: " answer
	case $answer in
		[Cc]* )
		computerName
		;;
		[Ii]* )
		ip
		;;
	esac
}

Main
