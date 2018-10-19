#!/usr/bin/bash
#Created By: J.Medlock
#Created On: 2016.12.05

showname(){
	show=$(printf "$file" | egrep -o '^([a-zA-Z]{1,3}.){,7}\b+' | tr '.' ' ')
}

episode(){
	episode=$(printf "$file" | egrep -o '([s|S][0-9]{2}[e|E][0-9]{2})')
}

for file in *.mkv ; do
	showname
	episode
	 mv -vi "$file" "$show$episode.mkv"
done

for file in *.mp4 ; do
	showname
	episode
	 mv -vi "file" "$show$episode.mp4"
done
