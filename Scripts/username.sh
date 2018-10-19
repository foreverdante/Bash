#!/bin/bash
# Script to search the the /etc/passwd file to find a specific username
yes=[Yy][Ee][Ss]
#no=[Nn][Oo]

userCreate() {
	if [[ ! $user ]] ; then
		echo "$userName does not exist..."
		read -p "Would you like to create this user? [Yes/No]: " create
		if [[ $create == $yes ]] ; then
			echo "Please wait while we create $userName"	
			sudo useradd $userName
			sleep 2
			echo "$userName has been created!"
			sleep 1
		else
			echo "Terminating..."
			sleep 3
			exit 0
		fi
	else
		echo $user
		break
	fi
}

groupCreate() {
	if [[ $group == $yes ]] ; then
		read -p "What group would you like to add $userName to? " groupAdd
		groupCheck=$(awk -F":" -v groupname="$groupAdd" '$0 ~ groupname' /etc/group)
		if [[ ! $groupCheck ]] ; then
			echo "Sorry, that group does not exist!"
			sleep 1
			echo "Terminating..."
			sleep 1
			exit 1
		else
			read -p "Confirm that you are adding $userName to $groupAdd: [Yes/No] " checking
			if [[ $checking == $yes ]] ; then
				sudo usermod -a -G $groupAdd $userName
				sleep 1
				echo "$userName has been added to $groupAdd!"
			else
				echo "$userName has not been added to $groupAdd!"
			fi
		fi
	else
		echo "$userName has been created but not added to a group!"
#		echo "Terminating..."
		sleep 2
#		exit 0
		break
	fi
}

#loops until user is finished searching for usernames
until [[ "$finished" = [Nn]o ]] ; do
	clear
	read -p "Please enter a name to search for: " userName
	#AWK will search for desired username in passwd file
	user=$(awk -F":" -v username="$userName" '$0 ~ username' /etc/passwd)
	userCreate
	echo ""
	read -p "Would you like to add $userName to any group(s)? " group
	groupCreate
	read -p "Would you like to search for another name? " finished
	if [[ $finished = [Yy][Ee][Ss] ]]; then
		clear
	else		
		echo "Terminating..."
		sleep 3
		exit 0
	fi
done
