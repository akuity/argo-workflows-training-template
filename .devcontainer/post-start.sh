#!/bin/bash

## Log it
echo "post-start start" >> ~/.status.log

## Best effort env loading
source ~/.bashrc

## Log it
echo "post-start complete" >> ~/.status.log
