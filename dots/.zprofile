source ~/.profile

if [ $(tty) = "/dev/tty1" ]; then pgrep bspwm || ssh-agent startx ~/.config/X11/xinitrc; fi
