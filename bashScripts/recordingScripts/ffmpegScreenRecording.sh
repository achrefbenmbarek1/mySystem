#!/bin/sh

isRecording=$(pgrep -c ffmpeg)
echo "$isRecording"
if [ "$isRecording" -eq 1 ]; then
  notify-send -t 3000 "Started recording"
  ffmpeg -y -f x11grab -s "$(xdpyinfo | grep dimensions | awk '{print $2;}')" -i :0.0 -f alsa -i default -c:v libx264 -r 30 -c:a flac out.mkv 
else
  killall --ignore-case --signal INT ffmpeg
  if [ $? -eq 0 ]; then
    notify-send "Recording saved"
  else
    notify-send -t 3000 "Error" "Couldn't stop the recording"
  fi
fi

