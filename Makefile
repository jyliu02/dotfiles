# Usage: make [target] V=-v

# Default target: restow all dotfile packages
.PHONY: all
all: restow

# List all stow packages (directories, excluding .git and files)
PACKAGES := $(filter-out .git,$(filter-out Makefile,$(wildcard */)))

# Allow passing flags to stow via V variable
STOW_FLAGS ?=

.PHONY: stow
stow:
	stow $(STOW_FLAGS) $(PACKAGES)

.PHONY: restow
restow:
	stow $(STOW_FLAGS) --restow $(PACKAGES)

.PHONY: unstow
unstow:
	stow $(STOW_FLAGS) --delete $(PACKAGES)

stow-%:
	stow $(STOW_FLAGS) $*

unstow-%:
	stow $(STOW_FLAGS) --delete $*

restow-%:
	stow $(STOW_FLAGS) --restow $*

.PHONY: deps-macos
deps-macos:
	brew install stow zsh fzf git neovim tmux ripgrep bat htop starship fd exa python node curl wget zoxide the_silver_searcher

.PHONY: deps-fedora
deps-fedora:
	sudo dnf install -y stow zsh fzf git neovim tmux ripgrep bat htop starship fd-find exa python3 nodejs npm curl wget zoxide the_silver_searcher

.PHONY: deps-arch
deps-arch:
	sudo pacman -Syu --needed stow zsh fzf git neovim tmux ripgrep bat htop starship fd exa python nodejs npm curl wget zoxide the_silver_searcher
