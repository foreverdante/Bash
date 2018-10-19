#!/bin/bash
#Created By: J.Medlock
#Created On: 08.24.2018

un="ad\\ldap"
pw="morscoLD@P"

ldapsearch -x -w "$pw" -b 'dc=ad,dc=morsco,dc=com' -D "$un" -h ad.morsco.com "CN=Cisco AnyConnect VPN" | grep "CN" | awk -F',' '{print $1}' | awk -F'=' '{print $2}' > group_members.csv

sed -i '/^Cisco.*$/d' group_members.csv
sed -i '/^Group.*$/d' group_members.csv
sed -i '/^Confi.*$/d' group_members.csv
