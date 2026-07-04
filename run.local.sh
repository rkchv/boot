#!/usr/bin/env bash
set -euo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file=./Brewfile

# Register asdf plugins (skip if already added)
asdf plugin list | grep -q '^golang$' || asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin list | grep -q '^nodejs$' || asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin list | grep -q '^lua$'    || asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git

# Install the pinned versions from .tool-versions and set them as the global default
cp ./.tool-versions "$HOME/.tool-versions"
asdf install

# Install the default stable Rust toolchain via rustup (idempotent)
rustup default stable

ansible-playbook ./local.yml --ask-become-pass --ask-vault-pass
