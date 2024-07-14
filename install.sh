#!/bin/bash

set -e

mkdir -p /home/sam/projects
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_activeprojects /home/sam/projects
echo '/dev/disk/by-id/scsi-0DO_Volume_activeprojects /home/sam/projects ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab

if [ -d "/home/sam/projects" ]; then
    echo "Volume attached successfully."
else
    echo "Volume attachment failed."
fi

if id "sam" &>/dev/null; then
    echo "User 'sam' already exists."
else
  adduser --gecos "" sam
  usermod -aG sudo sam
  chsh -s /usr/bin/zsh sam
fi

apt update
apt install -y zsh nodejs neovim git build-essential

# Install GitHub CLI
apt install -y curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update
apt install -y gh

chown -R sam:sam /home/sam
chown -R sam:sam /home/sam/projects

cp -r /root/.ssh /home/sam/
chown -R sam:sam /home/sam/.ssh

# Switch to 'sam' user and run the commands within EOF block
su - sam <<'EOF'
# Clone the nvimConfig repository to the appropriate location
cd /home/sam
git clone https://github.com/samdems/nvimConfig.git ~/.config/nvim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -f ~/.zshrc
wget https://raw.githubusercontent.com/samdems/devinit/main/.zshrc
EOF

# Change ownership of the cloned repository to 'sam'
chown -R sam:sam /home/sam/.config/nvim

echo "Setup completed for user 'sam'."

su sam



