#!/bin/bash

set -e

if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

echo "Installing Ansible..."
brew install ansible

if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible installation failed."
    exit 1
else
    echo "Ansible installed successfully."
fi

PLAYBOOK_PATH="./local.yml"

if [ ! -f "$PLAYBOOK_PATH" ]; then
    echo "Playbook file $PLAYBOOK_PATH not found!"
    exit 1
fi

echo "Running Ansible playbook: $PLAYBOOK_PATH"
# --vault-password-file
ansible-playbook "$PLAYBOOK_PATH" --ask-become-pass --ask-vault-pass

echo "Ansible playbook execution completed."
