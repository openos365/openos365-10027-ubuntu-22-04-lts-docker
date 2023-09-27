#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
export TERM=xterm-256color
echo $PROJECT_NAME
cd $CMD_PATH
env

whoami
pwd



######## create the users www and runner=======
cat /etc/group

groupadd www
groupadd runner

useradd -m -d /home/www -G sudo -g www www -s /bin/bash
useradd -m -d /home/runner -G sudo -g runner runner -s /bin/bash

echo "root:openos365" | chpasswd
echo "runner:openos365" | chpasswd
echo "www:openos365" | chpasswd

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

mkdir -p /etc/sudoers.d
echo "www ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/www-nopassword
echo "runner ALL=(ALL) NOPASSWD: ALL"   > /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/www-nopassword
chmod 750 /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/
cat /etc/passwd
###############################################


apt update -y
apt upgrade -y 

ln -sf "/usr/share/zoneinfo/Asia/Shanghai" "/etc/localtime"
apt install git -y
apt install build-essential -y 
apt install rename -y
apt install expect -y
apt install curl -y
apt install wget -y
apt install rsync -y
apt install python3 -y
apt install python2 -y
apt install sudo -y
apt install sqlite3 -y
apt install jq -y
apt install yq -y
apt install ruby -y
apt install vim -y
apt install systemd-sysv -y

curl -fsSL https://code-server.dev/install.sh | sh

systemctl enable code-server@root

systemctl enable code-server@runner

systemctl enable code-server@www

apt clean





