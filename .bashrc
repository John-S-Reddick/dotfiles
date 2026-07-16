# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Color Manpages
export MANROFFOPT="-c"
export MANPAGER="less --mouse --use-color -M +Gg -Dd+y -Du+c -DE+wr -DS+km"

# Alias Commands
alias bashrc='nvim ~/.bashrc'
alias ZZ='exit'
alias q='exit'
alias cls='clear'

# Alias Directories
alias cdnvim='cd ~/.config/nvim/lua'
alias cdaoc='cd ~/Documents/advent-of-code-2025' # !! Get rid of 2026

# Alias Files
alias nvmappings='nvim ~/.config/nvim/lua/mappings.lua'
alias nvoptions='nvim ~/.config/nvim/lua/options.lua'
alias nvlsp='nvim ~/.config/nvim/lua/configs/lspconfig.lua'
alias nvaf='nvim ~/.config/nvim/lua/configs/conform.lua'
alias nvautoformat='nvim ~/.config/nvim/lua/configs/conform.lua'
alias nvplugins='nvim ~/.config/nvim/lua/plugins/init.lua'


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
