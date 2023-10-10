#!/bin/bash

echo -n "$Username:$Password"

apt-get update && apt-get upgrade sudo -y

apt-get install -y openssh-server

mkdir /var/run/sshd

echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

sudo useradd -s /bin/bash -d /home/$Username/ -m -G sudo $Username

# adduser -h /home/$Username -s /bin/sh -D $Username

echo -n "$Username:$Password" | sudo chpasswd

# sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ssh-keygen -A

# Add Vault
sudo apt install gpg
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install vault

exec /usr/sbin/sshd -D -e "$@"
