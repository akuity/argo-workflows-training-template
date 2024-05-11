#!/bin/bash

## Log start
echo "post-create start" >> ~/.status.log

## Create k3s cluster
k3d cluster create --config .devcontainer/k3d.yaml --wait | tee -a ~/.status.log

## Install
kubectl apply -k ./install/argo-workflows | tee -a ~/.status.log

## Log things
echo "post-create complete" >> ~/.status.log
echo "--------------------" >> ~/.status.log
