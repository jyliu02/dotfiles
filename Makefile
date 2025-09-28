# Default target: restow all dotfile packages
.PHONY: all
all: restow

# List all stow packages (directories, excluding .git and files)
PACKAGES := $(filter-out .git,$(filter-out Makefile,$(wildcard */)))

# Stow all packages
.PHONY: stow
stow:
	stow $(PACKAGES)

# Restow all packages (unstow then stow)
.PHONY: restow
restow:
	stow --restow $(PACKAGES)

# Unstow all packages
.PHONY: unstow
unstow:
	stow --delete $(PACKAGES)

# Stow a specific package: make stow-PACKAGE (e.g., make stow-zsh)
stow-%:
	stow $*

# Unstow a specific package: make unstow-PACKAGE
unstow-%:
	stow --delete $*

# Restow a specific package: make restow-PACKAGE
restow-%:
	stow --restow $*

