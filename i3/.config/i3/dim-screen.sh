#!/bin/bash

# When receiving SIGHUP, stop fading and set backlight to original brightness.
# When receiving SIGTERM, wait a bit, and set backlight to original brightness
# (this prevents the screen from flashing before it is turned completely off
# by DPMS in the locker command).

BRIGHTNESS=$(brightnessctl get)
trap "brightnessctl set $BRIGHTNESS" EXIT
trap 'kill %%; exit 0' HUP
trap 'sleep 1s; kill %%; exit 0' TERM

MAX_BRIGHTNESS=$(brightnessctl max)
DIM_BRIGHTNESS=$(awk -v b="$BRIGHTNESS" -v max="$MAX_BRIGHTNESS" \
  'BEGIN { min = 0.1 * max; if (b < min) min = b; \
   dim = b - 0.15 * max; if (dim < min) dim = min; \
   print dim }')
brightnessctl set $DIM_BRIGHTNESS &
wait
sleep infinity & # No, sleeping in the foreground does not work
wait
