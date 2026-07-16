# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#Aliases
alias bashrc='nvim ~/.bashrc'
alias cdnvim='cd ~/.config/nvim/lua'
alias nvmappings='nvim ~/.config/nvim/lua/mappings.lua'
alias ZZ='exit'
alias q='exit'

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH=/usr/local/texlive/2026/bin/x86_64-linux/:$PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
fastfetch
