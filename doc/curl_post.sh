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

#!/bin/bash -x

cd ~/temp_work

export https_proxy=
export http_proxy=

#curl -O --data @/work/medrec/scripts/merged_short__for_service__post.json -i http://172.33.0.22:3005/list_pair/align.json -L --verbose

curl -O --data @/work/medrec/scripts/merged_short__for_service__post.json -i http://10.140.6.29:3005/list_pair/align.json -L --verbose

