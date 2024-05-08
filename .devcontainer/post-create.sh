#!/bin/bash

## Log start
echo "post-create start" >> ~/.status.log

## Create Kind cluster
kind create cluster --name workflows | tee -a ~/.status.log
kind export kubeconfig --name workflows | tee -a ~/.status.log

## Install Argo Workflows
export ARGO_WORKFLOWS_VERSION=v3.5.6
kubectl create namespace argo | tee -a ~/.status.log
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/install.yaml | tee -a ~/.status.log

## Log things
echo "post-create complete" >> ~/.status.log
echo "--------------------" >> ~/.status.log
