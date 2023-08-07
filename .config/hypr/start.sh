<<<<<<< HEAD
#!/run/current-system/sw/bin/bash
=======
#!/usr/bin/bash
>>>>>>> 39f17d0 (update all files)

#initialize wallpaper daemon
swww init &

#setting wallpaper
<<<<<<< HEAD
swww img ~/Wallpapers/leaves-wall.png &
=======
swww img ~/Wallpapers/Japan_pape_1.jpg &
>>>>>>> 39f17d0 (update all files)

nm-applet --indicator &

waybar &

mako &

<<<<<<< HEAD
blueman-manager & 

/nix/store/a4cnvr0lkp6qgblv595jklbzpdpx2ap4-polkit-kde-agent-1-5.27.6/libexec/polkit-kde-authentication-agent-1 &
=======
blueman-manager &
>>>>>>> 39f17d0 (update all files)

copyq --start-server &
