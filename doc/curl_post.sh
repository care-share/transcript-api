#!/bin/bash -x

cd ~/temp_work

export https_proxy=
export http_proxy=

#curl -O --data @/work/medrec/scripts/merged_short__for_service__post.json -i http://172.33.0.22:3005/list_pair/align.json -L --verbose

curl -O --data @/work/medrec/scripts/merged_short__for_service__post.json -i http://10.140.6.29:3005/list_pair/align.json -L --verbose

