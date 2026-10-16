# Claude Code sandbox: a dev container (rootless Podman) defined in
# ~/Documents/claude/.devcontainer. Only that folder is visible inside it, and
# its firewall only allows GitHub, npm, and Anthropic.
# Sourced by ~/.bashrc.

# Real path, not the /home symlink: the devcontainer CLI identifies the
# container by this path, so a different spelling would create a second one.
CBOX_DIR=$(realpath ~/Documents/claude)

# Run a devcontainer CLI subcommand (up, exec, ...) against the sandbox.
# Usage: _cbox <subcommand> [args...]
_cbox() { npx -y @devcontainers/cli "$1" --workspace-folder "$CBOX_DIR" --docker-path podman "${@:2}"; }

# Start the sandbox if it isn't running (no-op otherwise). This also re-applies
# the firewall. Build output is hidden; run `_cbox up` to see it when debugging.
_cbox_up() { _cbox up &>/dev/null || { echo "cbox: failed to start, run: _cbox up"; return 1; }; }

# Launch Claude inside the sandbox, passing any arguments through.
# e.g. cbox --dangerously-skip-permissions, cbox --continue
cbox() { _cbox_up && _cbox exec claude "$@"; }

# Open a zsh shell inside the sandbox.
cboxsh() { _cbox_up && _cbox exec zsh; }

# Stop the sandbox container. Volumes (Claude login, shell history) are kept.
cboxstop() { podman stop $(podman ps -q --filter "label=devcontainer.local_folder=$CBOX_DIR"); }
