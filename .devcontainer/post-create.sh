#!/bin/bash

## Log start
echo "post-create start" >> ~/.status.log

## Create Kind cluster
kind create cluster --name kargo-quickstart | tee -a ~/.status.log

## Log things
echo "post-create complete" >> ~/.status.log
echo "--------------------" >> ~/.status.log
