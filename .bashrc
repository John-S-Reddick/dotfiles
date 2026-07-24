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
alias a='clear && fastfetch'
alias l='colorls --sd' 
alias v='nvim'
alias f='open .' 
alias t='tmux'
alias c='clear'
alias e='exit'

# Alias Directories
alias cdnvim='cd ~/.config/nvim/lua'
alias cdaoc='cd ~/Documents/advent-of-code-2025' # !! Get rid of 2026
alias cdwriting='cd ~/Documents/writing'

# Alias Files
alias nvmappings='nvim ~/.config/nvim/lua/mappings.lua'
alias nvoptions='nvim ~/.config/nvim/lua/options.lua'
alias nvlsp='nvim ~/.config/nvim/lua/configs/lspconfig.lua'
alias nvaf='nvim ~/.config/nvim/lua/configs/conform.lua'
alias nvautoformat='nvim ~/.config/nvim/lua/configs/conform.lua'
alias nvplugins='nvim ~/.config/nvim/lua/plugins/init.lua'


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

# Create and manage Latex stuff
edit() {
    local base="${1%.*}"          # strip any extension the user typed
    local tex="${base}.tex"
    local pdf="${base}.pdf"

    if [[ ! -f "$tex" ]]; then
        echo "No such file: $tex — creating it"
        cat > "$tex" <<'EOF'
\documentclass{article}
\usepackage[utf8]{inputenc}

\title{}
\author{John Reddick}
\date{\today}

\begin{document}
\maketitle

\end{document}
EOF
        # Compile it so the PDF exists too
        pdflatex -interaction=nonstopmode -output-directory="$(dirname "$tex")" "$tex" >/dev/null 2>&1
        if [[ ! -f "$pdf" ]]; then
            echo "Warning: failed to generate $pdf from new $tex"
        fi
    fi

    # Open the PDF in the background (adjust viewer for your OS)
    if [[ -f "$pdf" ]]; then
        xdg-open "$pdf" >/dev/null 2>&1 &
        disown
    else
        echo "Warning: $pdf not found"
    fi

    # Open the tex file in nvim (foreground)
    nvim "$tex"
}
unset rc
fastfetch
