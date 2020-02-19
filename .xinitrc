#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

dwmbar & # Dwm status bar
xinput --set-prop 'SynPS/2 Synaptics TouchPad' "libinput Natural Scrolling Enabled" 1
xinput --set-prop 'SynPS/2 Synaptics TouchPad' "libinput Tapping Enabled" 1
/home/vgaleksa/.fehbg
unclutter & # Hide moouse pointer
clipmenud & # daemon to catch clips for clipmenu
sxhkd & # Bind keys universally
redshift -l 44.68:20.34 -t 5700:3600 -g 0.8 -m randr -v & # Blue light filter
xset s 180 120
xset dpms 3600 3600 3600
xss-lock -n 'dunstify -u critical "Screen will lock in 2 minutes"' -- slock &
dunst & # Notifier
# picom & # Composition manager

exec dwm
