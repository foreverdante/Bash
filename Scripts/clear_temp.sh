#!/bin/bash
#Created By: J.Medlock
#Created On: 07.31.2018

cd ~
read -p "Enter an IP address: " ip_address

# Mount the device to ${HOME}/windows_mnt/
sudo mount -t cifs //"$ip_address"/c$/users windows_mnt/ -o user=jbmedlock,password=N0tG3tt\!ng\!n

cd /home/jbmedlock/windows_mnt/

for x in $(ls | grep -Eo '^[a-z].*$'); do 
	cd /home/jbmedlock/windows_mnt/"$x"/AppData/Local/Temp/
	sudo rm -rfv *
done

