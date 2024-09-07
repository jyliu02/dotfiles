function append_path() {
    if [[ -d "$1" && ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

append_path $HOME/.local/bin
append_path $HOME/.local/scripts
append_path $HOME/.local/share/nvim/mason/bin
append_path $HOME/go/bin

# Preferred editor for local and remote sessions
export EDITOR="nvim"

# autostart
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx &>/dev/null
fi

export RANGER_LOAD_DEFAULT_RC=false
