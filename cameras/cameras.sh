#!/bin/bash
#Created By: JMedlock
#Created On: 05.06.2020

declare -A STREAM
#STREAM=([stream-000]=10.70.16.111 [stream-004]=10.70.16.127 [dallas-line1_sealant_pan]=10.70.16.245 [dallas-line2_sealant_pan]=10.70.16.246)
STREAM=([dallas-line2_sealant_pan]=10.70.16.111 [stream-004]=10.70.16.127 [dallas-line1_sealant_pan]=10.70.16.245)

# Check bash version
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]] ; then
  echo "Please upgrade your Bash version"
fi
#

for x in $(docker container ls | grep -Eo '[a-z]{1,}_[a-z]{1,}' | head -n -1);do docker kill ${x};done

# Iterate through STREAM array
for key in "${!STREAM[@]}"; do
  # Checks if array key is reachable through ICMP request
  if [[ $(ping -c1 -W1 "${STREAM[$key]}" | grep received | awk '{print $4}') == 0 ]]; then
    echo "$key is unavailable"
  else
    # Start rtsp feed via detached screen
    echo "Starting $key..."
    screen -d -S $key -m sudo /home/administrator/Intrinsics/intrinsics-streamer-v0.0.4/run-stream.sh rtsp://root:Intrinsics2021\!@${STREAM[$key]}/axis-media/media.amp tamko-$key
    echo -e "$key has been started\n"
  fi
done
