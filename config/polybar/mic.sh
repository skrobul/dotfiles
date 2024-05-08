#!/usr/bin/env bash
sink="$1"
sleep_pid=0

trap "toggle" USR1

toggle() {
  if [ "$sleep_pid" -ne 0 ]; then
    kill "$sleep_pid" >/dev/null 2>&1
  fi
}

while true; do
  result=$(pactl get-source-mute "$sink")

  if [[ "$result" == "Mute: yes" ]]; then
    echo "muted"
  else
    echo "%{F#ff0000}UNMUTED"
  fi

  sleep 2 & sleep_pid=$! wait
done
