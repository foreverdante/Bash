#!/usr/bin/bash
#Created By: J.Medlock
#Created On: 2017.01.04

read -p "Enter branch number: " branchip
if [[ ! $branchip =~ ^[0-9]{1,3}$ ]] ; then
	echo "$branchip does not appear to be a branch NUMBER"
	exit 1
fi

# Check range of branchip here
octet2=$((branchip%100))
piece3=$((branchip/100))
octet3=$((piece3*33))
thirdpiece=$((branchip*100/100))
thirdoctet=$((thirdpiece/branchip))

ip="10.$octet2.$octet3.*"
ip2="10.$octet2.$thirdoctet.*"
ip3="10.$octet2.1.*"

if [[ $branchip =~ ^1..$ ]] ; then
	nmap -sP $ip 2>/dev/null | grep '^Nmap' | awk '{print $5" "$6}'
elif [[ $branchip =~ ^..$ ]] ; then
	nmap -sP $ip2 | grep '^Nmap' | awk '{print $5" "$6}'
else
    nmap -sP $ip3 | grep '^Nmap' | awk '{print $5" "$6}'
fi
