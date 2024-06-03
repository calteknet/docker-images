#!/bin/bash

# Fetch the latest version tag from the IIAB GitHub repository
LATEST_VERSION=$(curl -s https://api.github.com/repos/iiab/iiab/releases/latest | jq -r .tag_name)

# Fetch the latest commit hash from the IIAB GitHub repository
LATEST_REVISION=$(curl -s https://api.github.com/repos/iiab/iiab/commits/main | jq -r .sha)

# Build the Docker image with the fetched version and revision
docker build --build-arg VERSION=$LATEST_VERSION --build-arg REVISION=$LATEST_REVISION -t iiab:latest .