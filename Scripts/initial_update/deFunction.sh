	if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
		sudo dnf install @cinnamon-desktop
	elif [[ -n $(find /etc/apt -name "apt") ]] ; then
		read -p "Are you using Ubuntu? " answer
		if [[ "$answer" == [Yy][Ee][Ss] ]] ; then
			echo "###################################################"
			echo "#     Which version of Ubuntu are you using?      #"
			echo "#                                                 #"
			echo "# Ubuntu 1[2].04                                  #"
			echo "# Ubuntu 1[4].04                                  #"
			echo "#                                                 #"
			echo "###################################################"
			echo ""
			read -p "Please enter your selection: " select
			case $select in
				2) sudo add-apt-repository ppa:tsvetko.tsvetkov/cinnamon;sudo apt-get update;sudo apt-get install cinnamon ;;
				4) sudo add-apt-repository ppa:lestcape/cinnamon;sudo apt-get update; sudo apt-get install cinnamon ;;
			esac
		elif [[ "$answer" == [Nn][Oo] ]] ; then
			read -p "Are you using Debian? " distroQuestion
			if [[ "$distroQuestion" == [Yy][Ee][Ss] ]] ; then
				sudo apt-get update
				sudo apt-get install linuxmint-keyring
				sudo apt-get update
				sudo apt-get install cinnamon cinnamon-session cinnamon-settings
			fi
		fi
	fi
