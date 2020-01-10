# .bashrc

# source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# enable powerline
if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/share/powerline/bash/powerline.sh
fi

# PS1 used when no powerline is available
export PS1="[\u@\h \W]\[$(tput bold)\]\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"

# ...
