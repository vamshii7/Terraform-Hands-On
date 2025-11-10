# 🌍 Terraform-Hands-On — Azure Cloud & Pipelines

[![Terraform](https://img.shields.io/badge/Terraform-v1.x-blueviolet?logo=terraform)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoft-azure)](https://azure.microsoft.com/)
[![CI/CD](https://img.shields.io/badge/Azure%20Pipelines-Enabled-success?logo=azure-pipelines)](https://learn.microsoft.com/en-us/azure/devops/pipelines/)
[![Repo](https://img.shields.io/badge/GitHub-Terraform--Hands--On-black?logo=github)](https://github.com/vamshii7/Terraform-Hands-On)
<!--[![License](https://img.shields.io/github/license/vamshii7/Terraform-Hands-On)](https://github.com/vamshii7/Terraform-Hands-On/blob/main/LICENSE)-->

---

## 📦 Description

**Terraform-Hands-On** is a curated lab for mastering infrastructure automation using **Terraform** on **Azure Cloud**, integrated with **Azure DevOps Pipelines**. It’s built for experimentation, learning, and collaboration — with modular examples and real-world CI/CD workflows.

---

## 🚀 Setup

### Prerequisites
- ✅ [Terraform](https://www.terraform.io/downloads.html) installed and added to your system `PATH`
- ✅ Azure CLI configured (`az login`)
- ✅ Azure DevOps organization and project
- ✅ Configured Self-hosted agent (e.g., VirtualBox VM) or Microsoft-hosted agent in agent pool
- ✅ Configured Service Connection to AZ Account for pipelines to run

### Getting Started  
```bash
# Clone the repo
git clone https://github.com/vamshii7/Terraform-Hands-On.git
cd Terraform-Hands-On

# Navigate to appropriate folder
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan and apply
terraform plan
terraform apply
```
## 🧠 Concepts

This repo covers key infrastructure and DevOps concepts:

- 🔧 Infrastructure as Code (IaC) with modular Terraform  
- ☁️ Azure resource provisioning (VMs, Storage, Networking)  
- 📦 Terraform state management and remote backends  
- 🧩 Kubernetes integration (AKS, HPA, NetworkPolicy)  
- 🔒 Role-based access and secure secrets handling  

---

## ⚙️ CI/CD — Azure DevOps

This project uses **Azure Pipelines** for automated provisioning and validation:

- 🧾 pipeline for Terraform deployment  
- 🔐 Secrets managed via Azure DevOps variable groups  
- 🧹 Linting, validation, and plan previews  
- 🌸 Auto-cleanup and state locking  

---

## ⏰ Roadmap

Planned enhancements:

- [x] Modular Terraform structure  
- [x] Azure DevOps pipeline integration  
- [ ] AKS cluster provisioning with HPA and RBAC  
- [ ] Helm chart deployment via Terraform  
- [ ] Monitoring with Azure Insights  

---

## 🤝 Contributing

We welcome improvements, optimizations, and new modules!

```bash
# Fork the repo
# Create a feature branch
git checkout -b feature/my-improvement

# Commit and push
git commit -m "Add AKS module"
git push origin feature/my-improvement
```
## 📚 Resources

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs) ↗️  
- [Azure DevOps Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines) ↗️  
- [Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) ↗️  

---

## 🛡️ License

MIT License — feel free to use, modify, and share.  

---

## ✍️ Authors

👨‍💻 **Vamshi Krishna**  
DevOps Engineer | DevOps & Kubernetes Enthusiast  

📫 Reach out on [GitHub](https://github.com/vamshii7)  | [LinkedIn](https://www.linkedin.com/in/vamshi7/)  
🌐 Focus Areas: Terraform, AKS, Azure DevOps, Kubernetes, and Cloud Automation  
🚀 Building hands-on labs for real-world learning!
