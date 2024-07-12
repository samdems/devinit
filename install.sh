#!/bin/bash

set -e

# Add user 'sam' with default settings
adduser --gecos "" sam
# Add 'sam' to the 'sudo' group
usermod -aG sudo sam

# Update package list and install necessary packages
apt update
apt install -y zsh nodejs neovim git build-essential

# Set zsh as the default shell for 'sam'
chsh -s /usr/bin/zsh sam

# Copy the .zshrc configuration file and .ssh directory to 'sam's home directory
cp .zshrc /home/sam/
cp -r .ssh /home/sam/
# Change ownership of the copied files to 'sam'
chown sam:sam /home/sam/.zshrc
chown -R sam:sam /home/sam/.ssh

# Switch to 'sam' user and run the commands within EOF block
su - sam <<'EOF'
# Clone the nvimConfig repository to the appropriate location
git clone https://github.com/samdems/nvimConfig.git ~/.config/nvim
EOF

# Change ownership of the cloned repository to 'sam'
chown -R sam:sam /home/sam/.config/nvim

echo "Setup completed for user 'sam'."

