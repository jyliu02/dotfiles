#!/bin/sh

maim /tmp/lock.png
magick /tmp/lock.png -scale 20% -blur 0x5 -resize 500% /tmp/lock-blurred.png
i3lock -n -i /tmp/lock-blurred.png
