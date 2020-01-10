# .bashrc


# ...


# enable powerline
if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/share/powerline/bash/powerline.sh
fi


export PS1="[\u@\h \W]\[$(tput bold)\]\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"


# ...
