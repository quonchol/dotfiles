git config --global user.email "git.kept777@passmail.net"
git config --global user.name "Phoenix"

yay -S tmux ufw tlp neovim hyprshade

sudo systemctl enable --now ufw tlp

sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo systemctl restart ufw
sudo ufw enable
