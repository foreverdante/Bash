#!/usr/bin/bash
#Created By: J.Medlock
#Created On: 2016.12.30

connmand

tether1=$(connmanctl services | grep AR | awk '{print $3}' | awk -F'_' '{print $2}')

tether2=$(connmanctl services | grep AO | awk '{print $3}' | awk -F'_' '{print $2}')

if [[ $tether1 == 'b8ca3a75613e' ]] ; then
    echo $tether1
    connmanctl move-before ethernet_$tether1\_cable ethernet_$tether2\_cable >/dev/null
	echo "fain988foam981" | sudo -S systemctl restart NetworkManager.service
else
    echo $tether1
    connmanctl move-before ethernet_$tether2\_cable ethernet_$tether1\_cable > /dev/null
	echo "fain988foam981" | sudo -S systemctl restart NetworkManager.service
fi
