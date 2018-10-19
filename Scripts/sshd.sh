#!/bin/bash
#This file was created on 11/02/2015
#Created by: J. Medlock

function TOP {
	echo "******************************************************************"
	echo "*                                                                *"
}

function BOTTOM {
	echo "* [E]xit                                                         *"
	echo "******************************************************************"
}

function Main {
	TOP
	echo "*         Would you like to start or stop SSH service?           *"
	echo "*                                                                *"
	echo "*                                                                *"
	echo "* 1) START                                                       *"
	echo "* 2) STOP                                                        *"
	echo "*                                                                *"
	BOTTOM
	echo ""
	read -p "Please make your selection (1 or 2): " select
	case $select in
		1) systemctl start sshd.service ;;
		2) systemctl stop sshd.service ;;
		Ee) * exit ;;
	esac
}

Main
exit 0

