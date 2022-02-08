#!/bin/bash

sudo cp -f /etc/vernemq/vmq.passwd /etc/vernemq/vmq-passwd.backup
sudo cp -f /etc/vernemq/vmq-passwd.unencrypted /etc/vernemq/vmq-passwd.unencrypted.backup

read -p "Please enter username to add: " username
read -p "Please enter password to add: " password

/usr/bin/expect << FOO
expect "Password: "
send -- "${password}\r"
expect "Reenter password: "
send -- "${password}\r"
expect "*#*"
FOO

echo -e "${username} : ${password}" >> /etc/vernemq/vmq-passwd.unencrypted
