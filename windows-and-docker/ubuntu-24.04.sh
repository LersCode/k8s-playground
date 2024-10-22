#!/usr/bin/env bash

USERNAME=$USER
echo "Setup docker for $USERNAME "
echo "Please make sure you have not installed Docker Desktop on your machine"

# Uninstall conflicting Packages
echo "Uninstalling conflicting Packages"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user $USER to docker group
usermod -aG docker $USER


# Create docker daemon config
echo "Create docker daemon config"

sudo bash -c 'cat <<EOF >/lib/systemd/system/docker-tcp.socket
[Unit]
Description=Docker Socket for the API
PartOf=docker.service

[Socket]
ListenStream=2375

BindIPv6Only=both
Service=docker.service

[Install]
WantedBy=sockets.target
EOF'

sudo systemctl daemon-reload
sudo systemctl stop docker.service
sudo systemctl enable docker-tcp.socket
sudo systemctl start docker-tcp.socket
sudo systemctl start docker.service

echo "Docker setup done"

echo "Check docker"
echo 'Please restart your shell and run "docker ps" to check if everything worked fine'