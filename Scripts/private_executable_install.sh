yay -S tmux nvim gammastep protonvpn-cli-community find-the-command syncthing ufw tlp
sudo systemctl enable --now syncthing@phoenix
sudo systemctl enable --now ufw tlp

sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo systemctl restart ufw
sudo ufw enable
