#!/bin/bash

docker buildx build --platform=linux/amd64,linux/arm64 --push --tag ipepe/nginx-basic-auth:latest .
