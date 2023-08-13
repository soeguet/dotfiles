#!/usr/bin/env bash

nm-applet --indicator &

#waybar &

waybar -c ~/.config/waybar/config.json &

mako &

blueman-manager &

copyq --start-server &
