#!/bin/bash

##
# Copyright 2016 The MITRE Corporation, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this work except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


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

