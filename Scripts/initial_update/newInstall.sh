##############################################################################################################################
#!/bin/bash                                                                                                                  # 
#                                                                                                                            #   
# Purpose: Does all initial setup                                                                                            #
# Author: J. Medlock                                                                                                         # 
# Date: 20151005                                                                                                             #
# Usage: To automate installation of different common packages                                                               #
#                                                                                                                            #
# This script will automate installing your initial update as well as setting up a cronjob to check for updates              #  
# every 30 days. This will help keep from having to remember to do monthly updates to your system.                           # 
##############################################################################################################################
# Variable Declaration
dnf="$(cat /etc/*-release | grep -i ^NAME | awk -F'=' '{print $2}')"
aptGet="$(cat /etc/*-release | grep -i "^NAME" | awk -F'"' '{print $2}' | cut -d' ' -f1)"
aptitude="$(cat /etc/*-release | grep -i "^NAME" | awk -F'"' '{print $2' | cut -d' ' -f1)"

# Border functions
function TOP {
echo "##########################################"
echo "#                                        #"
}

function BOTTOM {
echo "#                                        #"
echo "##########################################"
}

# Menu Functions
function vimMenu {
TOP
echo "#       What would you like to do?       #"
echo "#                                        #"
echo "# [I]nstall VIM enhanced                 #"
echo "# [S]et line numbers                     #"
echo "# [T]urn on syntax highlighting          #"
echo "#                                        #"
echo "# [M]ain Menu                            #"
BOTTOM
echo ""
read -p "Please enter your selection: " select
case $select in
	[Ii]* ) installVIM ;;
	[Ss]* ) setLines ;;
	[Tt]* ) syntaxHighlight ;;
	[Mm]* ) Main ;;
esac
}

function aptKDEFunction {
TOP
echo "#  Which version of KDE would you like?  #"
echo "#                                        #"
echo "# 1) KDE Full                            #"
echo "# 2) KDE Plasma                          #"
echo "# 3) Desktop Environments                #"
echo "#                                        #"
echo "# 4) Main Menu                           #"
BOTTOM
echo ""
read -p "Please enter your selection: " select
case $select in
	1) sudo apt-get install kde-full ;;
	2) sudo apt-get install kde-plasma-desktop ;;
	3) desktopEnv ;;
	4) Main ;;
esac
}

function distroMenu {
TOP
echo "#       Which OS are you running?        #"
echo "#                                        #"
echo "# 1) Ubuntu 12.04                        #"
echo "# 2) Ubuntu 14.04                        #"
echo "# 3) Debian                              #"
BOTTOM
echo ""
read -p "Please enter your selection: " select
case $select in
	1) ubuntu1204 ;;
	2) ubuntu1404 ;;
	3) debianOS ;;
esac
}

function desktopEnv {
TOP
echo "#       Which desktop environment        #"
echo "#         would you like to use?         #"
echo "#                                        #"
echo "# [C]innamon (Recommended for new users) #"
echo "# [E]nlightenment                        #"
echo "# [G]nome                                #"
echo "# [K]DE Desktop                          #"
echo "# [L]xde                                 #"
echo "# [M]ate                                 #"
echo "# [U]nity                                #"
echo "# [X]fce                                 #"
echo "#                                        #"
echo "# M[A]in Menu                            #"
BOTTOM
echo ""
read -p "Please enter your selection: " de
case $de in
	[Cc]* ) cinnamonDE ;;
	[Ee]* ) enlightenmentDE ;;
	[Gg]* ) gnomeDE ;;
	[Kk]* ) kdeDE ;;
	[Ll]* ) lxdeDE ;;
	[Mm]* ) mateDE ;;
	[Uu]* ) unityDE ;;
	[Xx]* ) xfceDE ;;
	[Aa]* ) Main ;;
esac
}

function Main {
clear
TOP
echo "#      What would you like to do?        #"
echo "#                                        #"
echo "#                                        #"
echo "# [U]pdate                               #"
echo "# [I]nstall VLC                          #"
echo "# [C]onfigure VIM                        #"
echo "# [D]esktop Environment                  #"
echo "# [E]xit                                 #"
BOTTOM
echo ""
read -p "Please enter your choice: " opt
case $opt in
	[Uu]* ) update ;;
	[Ii]* ) installVLC ;;
	[Cc]* ) vimMenu ;;
	[Dd]* ) desktopEnv ;;
	[Ee]* ) exit ;;
esac
}

# Operation Functions
function update {
	if [[ "$dnf" == "Fedora" ]] ; then
		read -p "Are you sure you want to update your system? " answer
		if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
			clear
			sudo dnf update
		else
			echo "Terminating..."
			sleep 2
			exit 0
		fi
	elif [[ "$aptGet" == "Ubuntu" ]] ; then
		read -p "Are you sure you want to update your system? " answer
			if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
				clear
				sudo apt-get update
			else
				echo "Terminating..."
				sleep 2
				exit 0
			fi
	elif [[ "$aptitude" == "Debian" ]] ; then
		read -p "Are you sure you want to update your system? " answer
			if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
				clear
				su -
				aptitude update
			else
				echo "Terminating..."
				sleep 2
				exit 0
			fi
	else
		echo "Sorry, your distribution is not supported."
		echo "Terminating..."
		sleep 2
	fi
}

function installVLC {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then	
		read -p "You are about to install VLC Media Player. Are you sure? " answer
			if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
				clear
				sudo rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
				sudo dnf install vlc
			else
				Main
			fi
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		read -p "You are about to install VLC Media Player. Are you sure? " answer
			if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
				clear
				sudo apt-get install vlc
			else
				Main
			fi
	fi
}

#####################################VIM functions###########################################
function installVIM {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then	
		read -p "You are about to install VIM Enhanced. Are you sure? " answer
			if [[ ("$answer" == [Yy][Ee][Ss]) || ("$answer" == [Yy]) ]] ; then
				clear
				sudo dnf -y install vim-enhanced
				alias vi=vim
			else
				Main
			fi
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then	
		read -p "You are about to install VIM Enhanced. Are you sure? " answer
			if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
				clear
				sudo apt-get install vim
				alias vi=vim
			else
				Main
			fi
	fi
}

function setLines {
	echo ":set number" >> $HOME/.vimrc
}

function syntaxHighlight {
	echo ":syntax on" >> $HOME/.vimrc
}

############################Desktop Environment Functions#####################################
function cinnamonDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		clear
		read -p "Are you sure you want to install Cinnamon Desktop Environment? " answer
		if [[  "$answer" == [Yy][Ee][Ss] ]] ; then
			clear
			sudo dnf install @cinnamon-desktop
		else
			desktopEnv
		fi
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		read -p "Are you using Ubuntu? " answer
		if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
			clear
			sudo add-apt-repository ppa:tsvetko.tsvetkov/cinnamon;sudo apt-get update;sudo apt-get install cinnamon
		elif [[ "$answer" == [Nn][Oo] ]] ; then
			read -p "Are you using Debian? " distroQuestion
			if [[ "$distroQuestion" == [Yy][Ee][Ss] ]] ; then
				clear
				sudo apt-get update
				sudo apt-get install linuxmint-keyring
				sudo apt-get update
				sudo apt-get install cinnamon cinnamon-session cinnamon-settings
			else
				desktopEnv
			fi
		else
			echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
			sleep 2
			desktopEnv
		fi
	fi
}

function kdeDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		clear
		sudo dnf install @kde-desktop
	elif [[  -n $(find /etc/apt -name "apt") ]] ; then
		clear
		aptKDEFunction
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function enlightenmentDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		clear
		sudo dnf install enlightenment
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		clear
		sudo add-apt-repository ppa:enlightenment-git/ppa
		sudo apt-get update
		sudo apt-get install e20 terminology
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function gnomeDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		clear
		sudo dnf install gnome
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		clear
		sudo apt-get install gnome
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function lxdeDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		clear
		sudo dnf install @lxde-desktop
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		clear
		sudo apt-get install lxde
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function mateDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		clear
		sudo dnf install @Mate
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		clear
		distroMenu
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function ubuntu1204 {
	if [[ -n $(find /etc/apt -name "apt") ]] ; then
		# Add repositories
		sudo apt-add-repository ppa:ubuntu-mate-dev/ppa
		sudo apt-add-repository ppa:ubuntu-mate-dev/precise-mate
		# Install full MATE desktop
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install mate-desktop
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function ubuntu1404 {
	if [[ -n $(find /etc/apt -name "apt") ]] ; then
		# Add repositories
		sudo apt-add-repository ppa:ubuntu-mate-dev/ppa
		sudo apt-add-repository ppa:ubuntu-mate-dev/trusty-mate
		# Install full MATE desktop
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install mate-desktop
	else 
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi	
}

function debianOS {
	if [[ -n $(find /etc/apt -name "apt") ]] ; then
		# Install full MATE desktop
		sudo apt-get update
		sudo apt-get install mate-desktop
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

function xfceDE {
	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		sudo dnf install @xfce
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		clear
		sudo apt-get update
		sudo apt-get install -y xfce4 xfce4-goodies
	else
		echo "Sorry, your distribution is not yet supported. Returning to Desktop Menu!"
		sleep 2
		desktopEnv
	fi
}

until [[ "$finished" == [Nn][Oo] ]] ; do
clear
Main
echo ""
read -p "Would you like to continue? " finished
done
