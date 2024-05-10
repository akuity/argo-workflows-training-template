# Argo Workflows Codespaces Template

A GitHub Codespaces repository for Argo Workflows Training.

## Overview

This codespace will create a kubernetes cluster with Argo Workflows installed, along with a
S3 (Minio) bucekt that is ready to be used for artifact storage.

## Workflow Permissions

Unless specified, Workflows will run pods with the `default` ServiceAccount. The following
command gives the pods the necessary privileges for communicating workflow results. This
is necessary for 

```
kubectl apply -f install/rbac/executor.yaml
```

## Start Argo Server

Argo Server is already exposed as a forwarded port in the codespace. If you

```
argo server --auth-mode=server --secure=false -n argo
```
