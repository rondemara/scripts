xset +fp /usr/share/fonts/local
xset fp rehash
ssh-agent &
sxhkd       2>&1 >/tmp/sxhkd.log &
exec bspwm  2>&1 >/tmp/bspwm.log
