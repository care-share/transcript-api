#!/bin/sh

# get IP address of this server
export host=$(awk "/$(hostname)/"' {print $1}' /etc/hosts | tail -n 1)
echo "localhost: $host"
echo "$host    test" >> /etc/hosts

unset http_proxy
unset https_proxy

# start server
rails server -p 3003
