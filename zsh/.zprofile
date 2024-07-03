function add_to_path() {
    if [[ -d "$1" && ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

export XDG_CONFIG_HOME=$HOME/.config

add_to_path $HOME/.local/bin
add_to_path $HOME/go/bin
add_to_path $HOME/.local/share/nvim/mason/bin

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
