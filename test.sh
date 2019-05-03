#!/bin/bash

GKE_BASE64_KEY=`cat /path/to/base64`
SCRIPT="https://raw.githubusercontent.com/viant/drone-gcloud/master/runme.sh"

docker run -e GKE_BASE64_KEY="$GKE_BASE64_KEY" -e SCRIPT=$SCRIPT viant/drone-gcloud
