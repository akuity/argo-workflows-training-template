# Argo Workflows Codespaces Template

A GitHub Codespaces repository for Argo Workflows Training.

## Overview

This codespace will create a kubernetes cluster with Argo Workflows installed, along with a
S3 (Minio) bucket that is ready to be used for artifact storage.

## Workflow Permissions

Unless specified, Workflows will run pods with the `default` ServiceAccount. The following
command gives the pods the necessary privileges for communicating workflow results. This
is necessary for 

```
kubectl apply -f install/rbac/executor.yaml
argo submit examples/hello-world.yaml
```

## Artifact Repositories

Workflows can be configured with an artifact repository to pass files from step to step.

```
kubectl apply -f examples/artifact/artifact-repositories.yaml
argo submit examples/artifact/artifact-passing.yaml
```

## Workflow Archive

Workflows can be persisted to a SQL database for long term storage.

Install postgres and reconfigure workflows to use a database:

```
kubectl apply -k install/workflow-archive
kubectl rollout restart deploy -n argo argo-server workflow-controller
```

Submit a workflow with a label indicating it should be archived.

```
argo submit examples/archived-wf.yaml --wait
```

The workflow will be deleted 5 seconds after completion (using `ttlStrategy`), but will still visible from the workflow UI.


## Start Argo Server

Argo Server is already exposed as a forwarded port in the codespace. If you

```
argo server --auth-mode=server --secure=false -n argo
```
