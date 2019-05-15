#!/bin/bash

GCLOUD='/google-cloud-sdk/bin/gcloud'

if [[ -n "$PLUGIN_GKE_BASE64_KEY" ]]
then
    echo $PLUGIN_GKE_BASE64_KEY | base64 -d - > /gcloud.json
else
    echo "GKE_BASE64_KEY required"
    exit 1
fi

# Set project
PROJECT=`cat /gcloud.json | jq -r .project_id`
if [[ $DEBUG == "True" ]]
then
    $GCLOUD config set project $PROJECT
else
    $GCLOUD config set project $PROJECT > /dev/null 2>&1
fi

if [[ $? == 0 ]]
then
    echo "Project set to : $PROJECT"
else
    echo "Unable to set project: $PROJECT"
    exit 1
fi

# Auth with JSON key
if [[ $DEBUG == "True" ]]
then
    $GCLOUD auth activate-service-account --key-file /gcloud.json 
else
    $GCLOUD auth activate-service-account --key-file /gcloud.json > /dev/null 2>&1
fi
if [[ $? == 0 ]]
then
    echo "JSON auth      : Success"
else
    echo "Unable to auth"
    exit 1 
fi

# Execute script if specified
if [ -n "$PLUGIN_SCRIPT" ]
then
    curl $SCRIPT -o /execute_me -s
    chmod +x /execute_me
    /execute_me
fi
