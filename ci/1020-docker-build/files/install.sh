#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
export TERM=xterm-256color
echo $PROJECT_NAME
cd $CMD_PATH
export METEOR_ALLOW_SUPERUSER=true

env

whoami
pwd


apt update -y
apt upgrade -y 

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



apt install -y rsync
apt install -y ca-certificates
rsync -avzP ./root/ /
apt update -y
apt upgrade -y 

ln -sf "/usr/share/zoneinfo/Asia/Shanghai" "/etc/localtime"
apt install -y locales
locale-gen en_US.UTF-8

apt install -y git 
apt install -y build-essential 
apt install rename -y
apt install expect -y
apt install curl -y
apt install wget -y

apt install python3 -y
apt install python2 -y
apt install sudo -y
apt install sqlite3 -y
apt install jq -y
apt install yq -y
apt install ruby -y
apt install vim -y
apt install systemd-sysv -y
apt install iputils-ping -y
apt install -y net-tools
apt install linux-image-6.2.0-33-generic -y
apt install libssl-dev -y
apt install sqlite3 -y
apt install ruby -y

apt install -y cmake
apt install -y libyaml-cpp-dev 
apt install -y nlohmann-json3-dev 
apt install -y libgtest-dev
apt install -y default-jdk
apt install -y maven
# GVM couldn't find hexdump
# https://askubuntu.com/questions/1131417/install-hexdump-in-an-ubuntu-docker-image
apt install -y bsdmainutils

function jabba_install()
{
  export HOME=/root
  export USER=root
  export JABBA_VERSION=0.11.2
  export JABBA_INDEX=https://github.com/typelevel/jdk-index/raw/main/index.json
  curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash 
  . /root/.jabba/jabba.sh
  for p_name in `jabba ls-remote`
  do
  	echo $p_name
       jabba install $p_name
  done
}
jabba_install


apt install golang -y
curl -s -S -L https://ghproxy.com/raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
source /root/.gvm/scripts/gvm
gvm install go1.17
gvm use go1.17

git clone https://github.com/cooperspencer/gickup.git
cd gickup
go build .
cp -fv ./gickup /usr/bin/gickup
which gickup
gickup --help


function ostree_build()
{
cd ~
git clone https://github.com/ostreedev/ostree.git
git submodule update --init
env NOCONFIGURE=1 ./autogen.sh
./configure
make
make install
}

ostree_build








curl -LO https://storage.googleapis.com/container-diff/latest/container-diff-linux-amd64
install container-diff-linux-amd64 /usr/bin/container-diff
rm -rf container-diff-linux-amd64

export DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb

curl -fsSL https://code-server.dev/install.sh | sh

# systemctl enable code-server@root

# systemctl enable code-server@runner

systemctl enable code-server@www

cd ~/
git clone https://github.com/gnuhub/connect-proxy.git
cd connect-proxy
gcc connect.c -o connect -lssl -lcrypto

rsync -avP ./connect /usr/bin/connect
chmod +x /usr/bin/connect
cd ~/
rm -rf connect-proxy

apt clean

mkdir ~/git/
mkdir ~/.ssh/

git config --global pull.rebase false

cd ~
git clone https://github.com/nvm-sh/nvm.git .nvm
cd .nvm
git checkout v0.39.5

cd ~
. ~/.nvm/nvm.sh

for node_version in "v14.21.3" "v16.20.2" "v18.18.0" "v20.8.0"
do
  nvm install $node_version
  nvm use $node_version
  npm install yarn -g
  npm install pnpm -g
done

nvm use v14.21.3
npm install meteor -g --unsafe-perm

export PATH=$HOME/.meteor:$PATH
echo $PATH
which node
node --version
set -x

npm  config set -g python /usr/bin/python2
yarn config set python /usr/bin/python2 -g

cd ~
git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash

cd ~
mkdir /etc/versions
rm -rf steedos-platform
git clone --depth=1 -b 2.5 https://github.com/steedos/steedos-platform.git
cd steedos-platform
yarn --frozen-lockfile
export PATH=$(yarn bin):$PATH
yarn list > /etc/versions/yarn.list.origin.txt
cd creator
which meteor
meteor --version
yarn --frozen-lockfile
meteor list
meteor list > /etc/versions/meteor.list.origin.txt
meteor list --tree > /etc/versions/meteor.list.tree.origin.txt
yarn build-debug
yarn list > /etc/versions/yarn.creator.list.origin.txt

yarn cache dir > /etc/versions/yarn.cache.dir.origin.txt
yarn cache list > /etc/versions/yarn.cache.list.origin.txt
apt list > /etc/versions/apt.list.origin.txt
apt list --installed > /etc/versions/apt.list.installed.origin.txt

sed -i '$d' /etc/versions/yarn.list.origin.txt
sed -i '$d' /etc/versions/yarn.creator.list.origin.txt
sed -i '$d' /etc/versions/yarn.cache.list.origin.txt

. ~/.bashrc

env > /etv/versions/env.txt

ls -al /etc/versions
date
