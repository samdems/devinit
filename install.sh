#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create a user called 'sam' and set up the home directory
adduser --gecos "" sam
usermod -aG sudo sam

# Install necessary packages
apt update
apt install -y zsh nodejs neovim git

# Copy .zshrc to the sam's home directory and set permissions
cp /root/.zshrc /home/sam/
chown sam:sam /home/sam/.zshrc

# Switch to the 'sam' user to set up configurations
su - sam <<'EOF'
# Clone the nvimConfig repository
git clone https://github.com/samdems/nvimConfig.git ~/.config/nvim
EOF

# Ensure the correct permissions for the nvim configuration directory
chown -R sam:sam /home/sam/.config/nvim

echo "Setup completed for user 'sam'."

