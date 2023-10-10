echo -n "$Username:$Password"

apk add --update --no-cache openssh

echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

adduser -h /home/$Username -s /bin/sh -D $Username

echo -n "$Username:$password" | chpasswd
