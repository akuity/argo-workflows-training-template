# Argo Workflows Codespaces Template

A GitHub Codespaces repository for Argo Workflows Training.

## Overview

This codespace will create a kubernetes cluster with Argo Workflows installed. It contains examples using various workflow features, including S3 artifact storage and archiving workflows into an SQL persistent store. 

## Instructions

These examples can be followed using GitHub Codespaces, or with a local cluster (e.g. minikube, k3s, kind, docker desktop). Follow the corresponding setup instructions 

### GitHub Codespaces 

1. Fork this repository
2. Click `< > Code` Codespaces
3. Select "Create codespcae on main"
4. Wait for the Codespace to come up and `kubectl get pods` starts working from the Terminal

### Local Cluster

If running a local cluster, apply the argo-workflows installation manifests:

```
kubectl apply -k ./install/argo-workflows
```

## Accessing the Argo and MinIO UI

### GitHub Codespaces 

* Argo UI: http://<localhost>:32746
* MinIO Console: http://localhost:30090

### Local Cluster

* Argo UI: http://localhost:32746
* MinIO Console: http://localhost:30090

## Workflow RBAC

Unless specified, Workflows will run pods with the `default` ServiceAccount. The following gives the pods the necessary privileges for communicating workflow results and running the examples in this tutorial.

```
kubectl apply -k install/rbac
argo submit examples/hello-world.yaml --watch
```

## Artifact Repositories

Workflows can be configured with an artifact repository to pass files from step to step.

Install minio s3 object store with the `mybucket` Bucket, and configure the bucket to be used as the default artifact repository for workflows in the namespace:

```
kubectl apply -k ./install/minio
kubectl apply -f examples/artifacts/artifact-repositories.yaml
```

Submit a workflow that passes artifacts between steps:
```
argo submit examples/artifacts/artifact-passing.yaml
```

Artifacts can be seen in the Minio console

## HTTP Template

Submit the HTTP Template example:

```
argo submit examples/http-template.yaml
```

## Plugin Template

Install the hello-executor plugin:
```
kubectl apply -n argo -f install/hello-executor-plugin/hello-executor-plugin-configmap.yaml
```
NOTE: the required step of enabling plugins has already been completed as part of the [install](install/argo-workflows/executor-plugins.yaml)

Submit the Plugin example:

```
argo submit examples/plugin-template.yaml
```

Uninstall:
```
kubectl delete -n argo -f install/hello-executor-plugin/hello-executor-plugin-configmap.yaml
```

## Workflow Archive

Workflows can be persisted to a SQL database for long term storage.

Install postgres and reconfigure workflows to use a database:

```
kubectl apply -k install/workflow-archive/
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
