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
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# auto mounting USB keys via udisks2 and udiskie
udiskie --no-notify --use-udisks2 &

# start gnome-keyring
# see: https://wiki.archlinux.org/index.php/GNOME/Keyring#Without_a_display_manager
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# setup the wallpaper
if [ -f "$HOME/.background-image" ] ; then
	feh --bg-scale $HOME/.background-image
fi

xss-lock -- /usr/bin/slimlock &

if [ -f "/usr/bin/i3" ]; then
	exec i3
fi
