sudo apt install zsh
sudo apt install npm
sudo apt install nodejs
cp .zshrc ~/
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

git clone https://github.com/samdems/nvimConfig.git ~/.config/nvim
