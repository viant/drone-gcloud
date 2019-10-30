#!/bin/bash

BASE64_KEY=`cat /path/to/base64`
SCRIPT="https://raw.githubusercontent.com/viant/drone-gcloud/master/runme.sh"

docker run -e BASE64_KEY="$BASE64_KEY" -e SCRIPT=$SCRIPT viant/drone-gcloud
