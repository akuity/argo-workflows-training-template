# Argo Workflows Codespaces Template

A GitHub Codespaces repository for Argo Workflows Training.

## Overview

This codespace will create a kubernetes cluster with Argo Workflows installed. It contains examples using various workflow features, including S3 artifact storage and archiving workflows into an SQL persistent store. 

## Workflow RBAC

Unless specified, Workflows will run pods with the `default` ServiceAccount. The following
command gives the pods the necessary privileges for communicating workflow results.

```
kubectl apply -f install/rbac/executor.yaml
argo submit examples/hello-world.yaml
```

## Artifact Repositories

Workflows can be configured with an artifact repository to pass files from step to step.

Install minio s3 object store with the `mybucket` Bucket, and configure the bucket to be used as the default artifact repository for workflows in the namespace:

```
kubectl apply -k ./install/minio
kubectl apply -f examples/artifact/artifact-repositories.yaml
```

Submit a workflow that passes artifacts between steps:
```
argo submit examples/artifact/artifact-passing.yaml
```

Artifacts can be seen in the Minio console


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


## Local Argo Server

Argo Server is typically run as internally reachable service for users to access and view workflows. Authentication can be via SSO or ServiceAccount tokens. However, in more secure/restrictive environments the workflows API server may not allowed to be exposed. In this scenario users can still run a local Argo API server on their workstation, so long as they have kubectl access to their namespace:

```
argo server --auth-mode=server --secure=false -n argo
```

The Workflow UI can then be browsed locally http://localhost:2746/.
