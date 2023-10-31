#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
# TODO HERE

cat /proc/version_signature
sudo df -h

# https://github.com/jlumbroso/free-disk-space/blob/main/action.yml
sudo rm -rf /opt/ghc

sudo apt-get remove -y '^dotnet-.*'
sudo apt-get remove -y '^llvm-.*'
sudo apt-get remove -y 'php.*'
sudo apt-get remove -y '^mongodb-.*'
sudo apt-get remove -y '^mysql-.*'
sudo apt-get remove -y azure-cli google-cloud-sdk google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri
sudo apt-get autoremove -y
sudo apt-get clean
echo "$AGENT_TOOLSDIRECTORY"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"
sudo df -h

echo "============================================================================"
