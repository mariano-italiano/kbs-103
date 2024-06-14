#!/bin/bash
# /usr/local/bin/k3s-uninstall.sh
# INSTALL PREREQUISITES

if [ -f /etc/apt/keyrings/docker.gpg ]; then
    sudo rm -f /etc/apt/keyrings/docker.gpg
fi

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# INSTALL K3S KUBERNETES
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server" INSTALL_K3S_VERSION="v1.29.2+k3s1" sh -s - --server "https://$1" --bind-address "$1" --write-kubeconfig-mode 644 --disable traefik --node-name k3s-master

# Marcin's command
#curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server" INSTALL_K3S_VERSION="v1.29.2+k3s1" sh -s - --server "https://$1" --bind-address "$1" --write-kubeconfig-mode 644 --disable traefik,servicelb --node-name k3s-master --flannel-backend=none --disable-network-policy

# INSTALL BASH COMPLETION
sudo apt-get install bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc

exit 0
