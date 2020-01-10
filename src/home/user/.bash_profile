# .bash_profile

# get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# user specific environment and startup programs
NPM_PACKAGES=$HOME/.npm-packages

export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$NPM_PACKAGES/bin
export MANPATH=$MANPATH:$NPM_PACKAGES/share/man
