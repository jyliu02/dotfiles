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

