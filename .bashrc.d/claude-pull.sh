# Pull ~/Documents/claude in the background when an interactive shell starts.
# Sourced by ~/.bashrc.

# Run only in interactive shells, at most once per 10 minutes.
if [[ $- == *i* && -d ~/Documents/claude/.git ]]; then
    _claude_stamp=~/.cache/claude-pull.stamp
    if [[ -z $(find "$_claude_stamp" -mmin -10 2>/dev/null) ]]; then
        mkdir -p ~/.cache && touch "$_claude_stamp"
        # The subshell hides job messages. GIT_TERMINAL_PROMPT=0 stops auth prompts.
        ( GIT_TERMINAL_PROMPT=0 timeout 30 git -C ~/Documents/claude pull --ff-only -q \
            &>/dev/null & )
    fi
    unset _claude_stamp
fi
