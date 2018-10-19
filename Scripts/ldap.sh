#!/usr/bin/bash
#Created By: J.Medlock
#Created On: 2017.10.04

username=$(read -p "Enter Username " user)
password=$(read -p "Enter Password " pass)

ldapsearch -x -w$password -b 'dc=msc,dc=morsco,dc=com' -D 'ad\$username' -h ad.morsco.com 'objectclass=*'
