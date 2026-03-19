#!/bin/sh
grim -g "$(slurp)" - | tee ~/Pictures/$(date +%s).png | wl-copy
