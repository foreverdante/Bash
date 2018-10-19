#!/bin/bash
#Created By: J.Medlock
#Created On: 01.25.2018

read -p "Enter in the last name to search for: " name

ldapsearch -x -w morscoLD@P -b 'OU=MSC,dc=ad,dc=morsco,dc=com' -D 'ad\ldap' -h ad.morsco.com "sn=$name"
