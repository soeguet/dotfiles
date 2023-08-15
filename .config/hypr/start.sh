#!/usr/bin/env bash

nm-applet --indicator &

#waybar &

waybar -c ~/.config/waybar/config.json &

mako &

gpaste-client &

workstyle &> /tmp/workstyle.log

#blueman-manager &

copyq --start-server &
