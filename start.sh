echo -n "$Username:$Password"

apt install -y openssh-server

mkdir /var/run/sshd

# echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

adduser -h /home/$Username -s /bin/sh -D $Username

echo -n "$Username:$Password" | chpasswd

sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ssh-keygen -A

exec /usr/sbin/sshd -D -e "$@"

sudo apt update && sudo apt install gpg
