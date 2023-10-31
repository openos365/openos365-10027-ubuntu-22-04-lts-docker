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
# https://github.com/jlumbroso/free-disk-space/blob/main/action.yml
sudo rm -rf /usr/local/lib/android
sudo rm -rf /opt/ghc
sudo rm -rf /usr/share/dotnet
sudo rm -rf /opt/ghc 
sudo rm -rf /usr/local/.ghcup

sudo apt-get remove -y '^aspnetcore-.*' || echo "::warning::The command [sudo apt-get remove -y '^aspnetcore-.*'] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^dotnet-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^dotnet-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^llvm-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^llvm-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y 'php.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y 'php.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^mongodb-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^mongodb-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^mysql-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^mysql-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y azure-cli google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri --fix-missing || echo "::warning::The command [sudo apt-get remove -y azure-cli google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y google-cloud-sdk --fix-missing || echo "::debug::The command [sudo apt-get remove -y google-cloud-sdk --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y google-cloud-cli --fix-missing || echo "::debug::The command [sudo apt-get remove -y google-cloud-cli --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get autoremove -y || echo "::warning::The command [sudo apt-get autoremove -y] failed to complete successfully. Proceeding..."
sudo apt-get clean || echo "::warning::The command [sudo apt-get clean] failed to complete successfully. Proceeding..."

sudo docker image prune --all --force || true

echo "$AGENT_TOOLSDIRECTORY"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"
sudo df -h

echo "============================================================================"
