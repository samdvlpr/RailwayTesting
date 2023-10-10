#!/bin/bash

echo -n "$Username:$Password"

apt-get update && apt-get upgrade -y

apt-get install -y openssh-server

mkdir /var/run/sshd

echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

useradd -s /bin/bash -d /home/$Username/ -m -G $Username

# adduser -h /home/$Username -s /bin/sh -D $Username

echo -n "$Username:$Password" | sudo chpasswd

# sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ssh-keygen -A

exec /usr/sbin/sshd -D -e "$@"

apt install gpg
