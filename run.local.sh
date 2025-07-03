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
brew install --cask raycast

asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf install golang latest
asdf set --home latest

asdf plugin add golangci-lint https://github.com/hypnoglow/asdf-golangci-lint.git
asdf install golangci-lint latest
asdf set --home golangci-lint latest

asdf plugin add go-swagger https://github.com/jfreeland/asdf-go-swagger.git
asdf install go-swagger latest
asdf set --home go-swagger latest

asdf plugin add mockery https://github.com/tolbier/asdf-mockery.git
asdf install mockery latest
asdf set --home mockery latest

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf set --home nodejs latest

asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git
asdf install lua 5.1
asdf set --home lua 5.1

ansible-playbook ./local.yml --ask-become-pass --vault-password-file ./secret.txt
