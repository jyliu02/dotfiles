function append_path() {
    if [[ -d "$1" && ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

export XDG_CONFIG_HOME=$HOME/.config

append_path $HOME/.local/bin
append_path $HOME/go/bin
append_path $HOME/.local/share/nvim/mason/bin

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

. "$HOME/.cargo/env"
