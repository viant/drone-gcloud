#!/bin/bash

GCLOUD='/usr/bin/gcloud'

# Decode key
echo $GKE_BASE64_KEY | base64 -d - > /gcloud.json

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

# Set cluster
if [[ $DEBUG == "True" ]]
then
    $GCLOUD container clusters get-credentials $CLUSTER --zone $ZONE
else
    $GCLOUD container clusters get-credentials $CLUSTER --zone $ZONE > /dev/null 2>&1 
fi
if [ $? == 0 ]
then
    echo "Cluster set to : $CLUSTER"
    echo "Zone set to    : $ZONE"
else
    echo "Unable to set zone: $ZONE or cluster: $CLUSTER"
    exit 1 
fi

# Execute script if specified
if [ -n "$SCRIPT" ]
then
    curl $SCRIPT -o /execute_me -s
    chmod +x /execute_me
    /execute_me
fi
