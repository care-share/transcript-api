#!/bin/sh

# get IP address of the docker host
dockerhost=$(/sbin/ip route|awk '/default/ { print $3 }')
echo "$dockerhost      dockerhost" >> /etc/hosts

# start server
rails server -p 3003

