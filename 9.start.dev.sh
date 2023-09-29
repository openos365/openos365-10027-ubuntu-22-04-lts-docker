#!/usr/bin/env bash
###
 # @Author: gnuhub gnuhub@qq.com
 # @Date: 2023-09-29 18:36:30
 # @LastEditors: gnuhub gnuhub@qq.com
 # @LastEditTime: 2023-09-29 18:45:33
 # @FilePath: /openos365/openos365-10027-ubuntu-22-04-lts-docker/9.start.dev.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

if [ ! -f ~/env.sh ];then
    cp -fv env.sh ~/env.sh
fi
docker-compose pull
docker-compose up -d
