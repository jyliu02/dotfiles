function add_to_path() {
    if [[ -d "$1" && ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

export XDG_CONFIG_HOME=$HOME/.config

add_to_path $HOME/.local/bin
add_to_path $HOME/go/bin
add_to_path $HOME/.zig-0.12.0
add_to_path $HOME/.zig-0.13.0


