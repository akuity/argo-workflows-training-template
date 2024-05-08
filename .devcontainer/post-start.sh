#!/bin/bash

## Log it
echo "post-start start" >> ~/.status.log

## Export Kubeconfig 
# kind export kubeconfig --name workflows | tee -a ~/.status.log

## Best effort env loading
source ~/.bashrc

## Log it
echo "post-start complete" >> ~/.status.log
