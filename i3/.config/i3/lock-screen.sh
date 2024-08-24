#!/bin/sh

maim -m 1 /tmp/lock.png 
magick /tmp/lock.png -blur 0x8 /tmp/lock.png
i3lock -n -i /tmp/lock.png
