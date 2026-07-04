#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ansible
brew install asdf
brew install tmux
brew install zsh
brew install pgcli
brew install hey
brew install fd
brew install fzf
brew install ripgrep
brew install stow
brew install lua luarocks
brew install watch
brew install dive
brew install --cask docker
brew install kubectl
brew install kind
brew install helm
brew install kustomize
brew install stern
brew install bat
brew install htop
brew install pgweb
brew install terraform
brew install eza
brew install jq
brew install httpie
brew install delve
brew install tmuxinator
brew install coreutils
brew install cmake
brew install ninja
brew install gettext
brew install --cask raycast

asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf install golang latest
asdf set --home latest

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf set --home nodejs latest

asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git
asdf install lua 5.1
asdf set --home lua 5.1

ansible-playbook ./local.yml --ask-become-pass --ask-vault-pass
