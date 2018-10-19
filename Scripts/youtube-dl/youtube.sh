#!/bin/bash

#######                       #######
#####        Dependencies       #####
#######                       #######

# youtube-dl
# aria2c

#######                            #######
#####        Download Location       #####
#######                            #######

LOCATE=$HOME/Videos/YouTube/%\(uploader\)s/%\(upload_date\)s_%\(title\)s.%\(ext\)s     #default download location
LOCATION=$HOME/Videos/YouTube/%\(uploader\)s/%\(upload_date\)s_%\(title\)s.%\(ext\)s     #User changeable download location

#######                                         #######
#####        Useful youtube-dl ammendments        #####
#######                                         #######

# --skip-download == skips download
# -s -- simulate
# --playlist-start NUMBER == defines start of selection
# --playlist-end NUMBER == defines end of selection
# --playlist-items ITEM_SPEC == specifies individual item in playlist
# --no-playlist == Does not download playlist if URL contains playlist
# --yes-playlist == does download playlist if URL contains playlist
# -f best == downloads the best quality video and audio
# --external-downloader == selects a seperate program to download file

#######                                                                 #######
#####                      Sections of the script                         #####
#####  (each section must be placed before a section which refers to it)  #####
#######                                                                 #######

TOP(){
clear
echo "#########################################################################"
echo "#                                                                       #"
}

BOTTOM(){
echo "#                                                                       #"
echo "#########################################################################"
}

BOTTOM_URL(){
echo ""
echo "URL : $URL"
echo ""
}

DOWNLOADING(){
TOP
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                         Downloading...                                #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                                                                       #"
BOTTOM_URL
}

COMPLETE(){
TOP
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                           Complete!                                   #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                                                                       #"
BOTTOM
echo ""
echo "Download location = $LOCATION"
echo ""
exit
}

Selection(){
TOP
echo "#                                                                       #"
echo "#                                                                       #"
echo "#        Please enter the number of the start of the selection          #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                                                                       #"
BOTTOM_URL
echo ""
echo -n "> "
read START
TOP
echo "#                                                                       #"
echo "#                                                                       #"
echo "#        Please enter the number of the end of the selection            #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                                                                       #"
BOTTOM_URL
echo "Start = $START"
echo -n "> "
read END
DOWNLOADING
echo "Start = $START"
echo "End = $END"
echo ""
echo "Download location = $LOCATION"
echo ""
youtube-dl -f bestvideo[ext=mp4]+bestaudio --external-downloader aria2c --yes-playlist --playlist-start $START --playlist-end $END -o "$LOCATION" $URL
COMPLETE
}

Whole(){
DOWNLOADING
echo "Download location = $LOCATION"
echo ""
youtube-dl -f bestvideo[ext=mp4]+bestaudio --external-downloader aria2c --yes-playlist -o "$LOCATION" $URL
COMPLETE
}

Playlist(){
TOP
echo "#               You have chosen to download a playlist.                 #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                    Enter the URL of the playlist                      #"
echo "#                       (( use Ctrl+Shift+V ))                          #"
BOTTOM
echo ""
echo ""
echo ""
echo ""
echo ""
echo -n "> "
read URL
TOP
echo "#             Do you wish to download a selection of videos             #" 
echo "#                        or the whole playlist?                         #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                       [S]election / [W]hole                           #"
echo "#                                                                       #"
BOTTOM_URL
echo ""
echo -n "> "
read opt
case $opt in
	[Ss]* )
	Selection
	;;
	[Ww]* )
	Whole
	;;
esac
}

Single(){
TOP
echo "#               You have chosen to download a single video.             #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                       Enter the URL of the video                      #"
echo "#                         (( use Ctrl+Shift+V ))                        #"
BOTTOM
echo ""
echo ""
echo ""
echo -n "> "
read URL
#clear
DOWNLOADING
echo "Download location = $LOCATION"
echo ""
youtube-dl -f bestvideo[ext=mp4]+bestaudio --external-downloader aria2c --no-playlist -o "$LOCATION" $URL
sleep 15
COMPLETE
}

Download_Location(){
TOP
echo "#             You have chosen to change the download location           #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                Enter the path you wish to download to                 #"
echo "#                                                                       #"
echo "#           See documentation of youtube-dl for correct syntax          #"
BOTTOM
echo ""
echo "Default :"
echo "$LOCATE"
echo "Current :"
echo "$LOCATION"
echo -n "> "
read LOCATION
Advanced
}

Advanced(){
TOP
echo "#                                                                       #"
echo "#                     You are now in the advanced menu.                 #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                       [C]hange download location                      #"
echo "#                               [M]ain Menu                             #"
BOTTOM
echo ""
echo ""
echo ""
echo -n "> "
read opt
case $opt in
	[Cc]* )
	Download_Location
	;;
	[Mm]* )
	Main
	;;
esac
}

Extract(){
TOP
echo "#                                                                       #"
echo "#                 You have chosen to download only the audio            #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                       Enter the URL of the video                      #"
echo "#                         (( use Ctrl+Shift+V ))                        #"
BOTTOM
echo ""
echo ""
echo ""
echo -n "> "
read URL
clear
DOWNLOADING
echo "Download location = $LOCATION"
echo ""
youtube-dl --extract-audio --audio-format mp3 --external-downloader aria2c --no-playlist -o "$LOCATION" $URL
COMPLETE
}

Main(){
TOP
echo "#                                                                       #"
echo "#          Do you want to download a playlist or a single video?        #"
echo "#                                                                       #"
echo "#                                                                       #"
echo "#                           [P]laylist / [S]ingle                       #"
echo "#                           [E]xtract / [A]dvanced                      #"
BOTTOM
echo ""
echo ""
echo ""
echo -n "> "
read opt
case $opt in
	[Pp]* )
	Playlist         
	;;
	[Ss]* )
	Single
	;;
	[Aa]* )
	Advanced         
	;;
	[Ee]* )
	Extract
	;;
esac
}

#######                       #######
#####         Run Script        #####
#######                       #######

Main
