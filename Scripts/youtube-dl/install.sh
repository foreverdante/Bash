##############################################################################################################################
#!/bin/bash                                                                                                                  # 
#                                                                                                                            #   
# Purpose: This script is going to install needed dependancies for software package                                          #
# Author: J. Medlock                                                                                                         # 
# Date: 20151012                                                                                                             #
# Usage: This script is going to install needed dependancies for software package                                            #
#                                                                                                                            #
#                                                                                                                            #  
#                                                                                                                            # 
##############################################################################################################################

#distro="$(lsb_release -a | grep -i Distributor\ ID: | awk '{print $3}')"
#distroList="$(awk -v distro="$distro" '$0 ~ distro' ~/Documents/Scripts/bash/ListOfDistros.txt)"
#findRPM="$(find /etc/dnf)"
#findAPT="$(find /etc/apt)"
if [[ -n $(find /etc/dnf -name "dnf") ]] ; then
	sudo dnf install youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl
	sudo dnf install aria2
	sudo dnf install ffmpeg
elif [[ -n $(find /etc/apt -name "apt") ]] ; then
	sudo add-apt-repository ppa:nilarimogard/webupd8
	sudo apt-get update
	sudo apt-get install youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl
	sudo apt-get install aria2
	sudo apt-get install ffmpeg
else
	echo "We have had a problem finding your package manager"
fi
