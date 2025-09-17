# Tic-Tac-Toe — AKS Deployment (Terraform + Azure Pipelines)
This repo contains Terraform infra and Azure Pipelines to deploy the tic-tac-toe app to AKS.
Structure:
- infra/global-bootstrap: creates TF state storage
- infra/aks: VNet, ACR, AKS
- infra/ingress: Helm-based ingress (nginx)
- app: Dockerfile, k8s manifests, helm chart
- azure-pipelines: infra and app pipeline definitions
