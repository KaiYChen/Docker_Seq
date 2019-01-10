#!/bin/bash
docker build -t build:v1 .
docker rmi $(docker images -f "dangling=true" -q)
docker tag build:v1 kychen/ubuntu_combio:v_1
docker push kychen/ubuntu_combio:v_1
docker rmi kychen/ubuntu_combio:v_1