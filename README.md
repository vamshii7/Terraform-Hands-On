# 🌍 Terraform-Hands-On — Azure Cloud & Pipelines

[![Terraform](https://img.shields.io/badge/Terraform-v1.x-blueviolet?logo=terraform)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoft-azure)](https://azure.microsoft.com/)
[![CI/CD](https://img.shields.io/badge/Azure%20Pipelines-Enabled-success?logo=azure-pipelines)](https://learn.microsoft.com/en-us/azure/devops/pipelines/)
[![License](https://img.shields.io/github/license/vamshii7/Terraform-Hands-On)](https://github.com/vamshii7/Terraform-Hands-On/blob/main/LICENSE)
[![Repo](https://img.shields.io/badge/GitHub-Terraform--Hands--On-black?logo=github)](https://github.com/vamshii7/Terraform-Hands-On)

---

## 📦 Description

**Terraform-Hands-On** is a curated lab for mastering infrastructure automation using **Terraform** on **Azure Cloud**, integrated with **Azure DevOps Pipelines**. It’s built for experimentation, learning, and collaboration — with modular examples and real-world CI/CD workflows.

---

## 🚀 Setup

### Prerequisites
- ✅ [Terraform](https://www.terraform.io/downloads.html) installed and added to your system `PATH`
- ✅ Azure CLI configured (`az login`)
- ✅ Azure DevOps organization and project
- ✅ Self-hosted agent (e.g., VirtualBox VM) or Microsoft-hosted agent

### Getting Started
```bash
# Clone the repo
git clone https://github.com/vamshii7/Terraform-Hands-On.git
cd Terraform-Hands-On

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan and apply
terraform plan
terraform apply
