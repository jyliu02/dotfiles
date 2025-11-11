# Usage: make [target] V=-v

# Default target: restow all dotfile packages
.PHONY: all
all: git-submodules-sync restow

# List all stow packages (directories, excluding .git and files)
PACKAGES := $(filter-out .git,$(filter-out Makefile,$(wildcard */)))

.PHONY: stow
stow:
	stow $(PACKAGES)

.PHONY: restow
restow:
	stow --restow $(PACKAGES)

.PHONY: unstow
unstow:
	stow --delete $(PACKAGES)

stow-%:
	stow $*

unstow-%:
	stow --delete $*

restow-%:
	stow --restow $*

.PHONY: git-submodules-sync
git-submodules-sync:
	# git submodule update --init --recursive --depth 1
	git submodule update --remote --recursive --depth 1

.PHONY: deps-macos
deps-macos:
	brew install stow zsh fzf git neovim tmux ripgrep bat htop fd python node curl wget zoxide reattach-to-user-namespace
	curl -sS https://starship.rs/install.sh | sh

.PHONY: deps-fedora
deps-fedora:
	sudo dnf install -y stow zsh fzf git neovim tmux ripgrep bat htop fd-find python3 nodejs npm curl wget zoxide
	curl -sS https://starship.rs/install.sh | sh

.PHONY: deps-arch
deps-arch:
	sudo pacman -Syu --needed stow zsh fzf git neovim tmux ripgrep bat htop fd python nodejs npm curl wget zoxide
	curl -sS https://starship.rs/install.sh | sh

.PHONY: cron-install
cron-install:
	crontab cron/crontab

.PHONY: cron-backup
cron-backup:
	crontab -l > cron/crontab || true

.PHONY: cron-remove
cron-remove:
	crontab -r
