[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
udiskie &
exec i3
