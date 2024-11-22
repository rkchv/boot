#!/bin/bash

set -e

# Function to get the latest stable version of Python
get_latest_python_version() {
  echo "Fetching the latest stable version of Python..."
  # Fetch the latest Python version from the official website
  latest_version=$(curl -s https://www.python.org/doc/versions/ | grep -oP 'Download Python \K[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
  echo "Latest Python version: $latest_version"
  echo "$latest_version"
}

# Install Python if not found
if ! command -v python3 &>/dev/null; then
  echo "Python not found. Installing Python..."

  latest_version=$(get_latest_python_version)

  curl -O "https://www.python.org/ftp/python/$latest_version/python-$latest_version-macosx10.9.pkg"
  sudo installer -pkg "python-$latest_version-macosx10.9.pkg" -target /
  rm "python-$latest_version-macosx10.9.pkg"
else
  echo "Python is already installed."
fi

# Check and install pip if not found
if ! command -v pip3 &>/dev/null; then
  echo "pip not found. Installing pip..."
  python3 -m ensurepip --upgrade
else
  echo "pip is already installed."
fi

# Install Ansible
echo "Installing Ansible..."
pip3 install ansible

USER_BIN_DIR="/Users/roman/Library/Python/3.9/bin"

if [[ ":$PATH:" != *":$USER_BIN_DIR:"* ]]; then
  export PATH="$USER_BIN_DIR:$PATH"
else
  echo "$USER_BIN_DIR in path already"
fi

# Check if Ansible was installed successfully
if ! command -vvv ansible-playbook &>/dev/null; then
  echo "Ansible installation failed."
  exit 1
else
  echo "Ansible installed successfully."
fi

# Path to the Ansible playbook
PLAYBOOK_PATH="./darwin.yml"

# Check if the playbook file exists
if [ ! -f "$PLAYBOOK_PATH" ]; then
  echo "Playbook file not found at $PLAYBOOK_PATH!"
  exit 1
fi

# Run the Ansible playbook
echo "Running Ansible playbook: $PLAYBOOK_PATH"
# --vault-password-file
ansible-playbook -vv "$PLAYBOOK_PATH" --ask-become-pass --vault-password-file="$HOME/vault_pass.txt"

echo "Ansible playbook execution completed."
