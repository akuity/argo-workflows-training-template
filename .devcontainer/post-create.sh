#!/bin/bash

## Log start
echo "post-create start" >> ~/.status.log

## Create k3s cluster
export K3S_VERSION=v1.27.13-k3s1
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d cluster get k3s-default || k3d cluster create --image rancher/k3s:${K3S_VERSION} --wait | tee -a ~/.status.log
k3d kubeconfig merge --kubeconfig-merge-default | tee -a ~/.status.log

## Install
kustomize build ./install/argo-workflows | kubectl apply -f - | tee -a ~/.status.log
kustomize build ./install/minio | kubectl apply -f - | tee -a ~/.status.log

## Log things
echo "post-create complete" >> ~/.status.log
echo "--------------------" >> ~/.status.log
