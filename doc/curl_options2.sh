#!/bin/bash

#curl -X OPTIONS http://localhost:3005/list_pair/align.json

export https_proxy=
export http_proxy=

# ip address according to browser (where did this ip come from???)
IP=10.140.6.29


# local ip address according to ifconfig
#IP=172.33.0.22

curl \
  --verbose \
  --request OPTIONS \
  http://${IP}:3005/list_pair/align.json \
  --header "Origin: http://${IP}:3005" \
  --header 'Access-Control-Request-Headers: Origin, Accept, Content-Type' \
  --header 'Access-Control-Request-Method: POST'

