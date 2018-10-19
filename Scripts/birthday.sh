#!/usr/bin/bash
#Created By: J.Medlock
#Created On: 2017.10.13

read -p "Enter your birthday in YYYY/MM/DD format: " birthday
#birthday="2018/05/20"

days=$(echo $(expr '(' $(date -d "$birthday" +%s) - $(date +%s) + 86399 ')' / 86400) " days until your birthday")

echo "$days"


#+ read -p 'Enter your birthday in YYY/MM/DD format: ' birthday
#Enter your birthday in YYY/MM/DD format: 2018/05/20
#++++ date -d 2018/05/20 +%s
#++++ date +%s
#+++ expr '(' 1526792400 - 1507922601 + 86399 ')' / 86400
#++ echo 219 ' days until your birthday'
#+ days = 219 days until your birthday
#birthday.sh: line 7: days: command not found
#+ echo ''

