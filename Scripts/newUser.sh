#!/bin/bash
# Script to search the the /etc/passwd file to find a specific username

#Declare GLOBAL variables
yes=[Yy][Ee][Ss]
no=[Nn][Oo]
shortyes=[Yy]
shortno=[Nn] 

# Functions ###################################################################################################################################################################################################
userCreate() {
    if [[ ! $user ]] ; then
        echo "$userName does not exist..."
        read -p "Would you like to create this user? [Yes/No]: " create
        if [ $create == $yes ] ; then
            echo "Please wait while we create $userName"   
            sudo useradd $userName
            sleep 2
            echo "$userName has been created!"
            sleep 1
	elif [[ $create == $shortyes ]] ; then
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
    fi
}
 
groupCreate() {
    if [[ $group == $yes ]] ; then
        read -p "What group would you like to add $userName to? " groupAdd
        groupCheck=$(awk -F":" -v groupname="$groupAdd" '$0 ~ groupname' /etc/group)
        if [[ ! $groupCheck ]] ; then
            echo "Sorry, that group does not exist!"
	    echo "$userName has still been created!"
            sleep 2
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
    elif [[ $group == $shortyes ]] ; then
        read -p "What group would you like to add $userName to? " groupAdd
        groupCheck=$(awk -F":" -v groupname="$groupAdd" '$0 ~ groupname' /etc/group)
        if [[ ! $groupCheck ]] ; then
            echo "Sorry, that group does not exist!"
	    echo "$user has still been created!"
            sleep 2
            echo "Terminating..."
            sleep 1
            exit 1
        else
            read -p "Confirm that you are adding $userName to $groupAdd: [Yes/No] " checking
            if [[ $checking == $yes ]] ; then
                sudo usermod -a -G $groupAdd $userName
                sleep 1
                echo "$userName has been added to $groupAdd!"
 	    elif [[ $checking == $shortyes ]] ; then
                sudo usermod -a -G $groupAdd $userName
                sleep 1
                echo "$userName has been added to $groupAdd!"
            else
                echo "$userName has not been added to $groupAdd!"
            fi
        fi
    else
        echo "$userName has been created but not added to a group!"
        echo "Terminating..."
        sleep 2
        exit 0
    fi
}
###############################################################################################################################################################################################################
 
#loops until user is finished searching for usernames
until [[ "$finished" = $no ]] ; do
    clear
    echo "**********************************************************************"
    echo "*                                                                    *"
    echo "* WARNING! Superuser privileges will be required for certain actions *"
    echo "*                                                                    *"
    echo "**********************************************************************"
    echo ""
    read -p "Please enter a name to search for: " userName
    #AWK will search for desired username in passwd file
    user=$(awk -F":" -v username="$userName" '$0 ~ username' /etc/passwd)
    userCreate												# Creates user account
    echo ""
    if [[ ! $user ]] ; then 										# As long as the searched user does not exist, continue to place user in a group
    	read -p "Would you like to add $userName to any group(s)? " group
    	groupCreate											# Actually places new account in specified group
    else
	echo "User already exists!"
    fi

    read -p "Would you like to search for another name? " finished
    if [[ $finished == $yes ]]; then
        clear
    elif [[ $finished == $shortyes ]] ; then
	clear
    else       
        echo "Terminating..."
        sleep 3
        exit 1
    fi
done
