if [ -f ~/env.sh ];then
   . ~/env.sh
fi

if [ ! -z $my_socks5_proxy ];then
    export socks5_proxy=$my_http_proxy
    export GIT_PROXY_COMMAND="/usr/bin/socks5proxywrapper"
    export GIT_SSH="/usr/bin/socks5proxyssh"
fi

if [ ! -z $my_http_proxy ];then
    export http_proxy=$my_http_proxy
    export https_proxy=$my_http_proxy
fi