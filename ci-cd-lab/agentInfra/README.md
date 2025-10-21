# 🚀 Terraform Azure DevOps Self-Hosted Agent (Agent VM)

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?logo=terraform)](https://www.terraform.io/) 
[![Azure DevOps](https://img.shields.io/badge/Azure%20DevOps-Pipeline-0078D7?logo=azuredevops)](https://dev.azure.com/) 
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20LTS-E95420?logo=ubuntu)](https://ubuntu.com/) 
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📖 Project Summary
This repository provisions a **minimal Ubuntu VM in Azure** and registers it as an **Azure DevOps self-hosted agent** using Terraform and an Azure DevOps pipeline.  

The pipeline:
- Runs `terraform init/plan/apply`
- Captures the VM IP
- Verifies agent registration in Azure DevOps
- Uses a **manual approval stage** before gracefully de-registering the agent and destroying the VM

---

## 📂 Repository Structure

agentInfra/  
├── main.tf # Creates RG, VNet, Subnet, Public IP, NIC, NSG, and Ubuntu VM  
├── provider.tf # Provider config + backend stanza  
├── variables.tf # Declares ado_org_url, ado_pat (sensitive), admin_password  
├── outputs.tf # Outputs vm_name and vm_public_ip  
├── azure-pipeline.yaml # Azure DevOps pipeline for provisioning & teardown  


---

## ⚡ Features & Behavior
- 🖥️ Creates a **Standard_B1s Ubuntu VM (Jammy Gen2)**
- 🔑 Generates a unique agent name (`agent-1234`)
- 📦 Installs **Azure DevOps agent vsts-agent-linux-x64-4.261.0**
- 🔗 Registers agent in the **Default pool** using `ado_pat`
- ✅ Includes **manual approval** before destroy
- 🧹 Gracefully **de-registers agent** before `terraform destroy`

---

## 🛠️ Prerequisites

### 🔹 Azure
- Subscription with permissions to create **RG, VNet, Public IP, NIC, VM**
- Resource Group for Terraform backend (if using `azurerm` backend)

### 🔹 Azure DevOps
- Organization URL (e.g. `https://dev.azure.com/yourOrg`)
- Personal Access Token (PAT) with `Agent Pools (read & manage)` scope
- Service Connection (e.g. `TerraformConnection`) with backend storage access

### 🔹 Pipeline Secrets
Create a **Variable Group** named `AgentSecrets`:
- `ado_org_url` (string)
- `ado_pat` (secret)
- `admin_password` (secret)

### 🔹 Local Testing (optional)
- Install [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)

---

## 📝 Example `terraform.tfvars`
```hcl
# ⚠️ DO NOT COMMIT REAL SECRETS
ado_org_url    = "https://dev.azure.com/myOrg"
ado_pat        = "<ADO_PAT_PLACEHOLDER>"
admin_password = "<VM_ADMIN_PASSWORD>"

```

##🎯 Benefits  
- Lifecycle: Fully automated agent lifecycle — provision, register, de-register, destroy
- Cost: No permanent infra costs — VM exists only when needed
- Scale: Scalable & reusable — replicate pipeline for multiple agents
- Isolation: Clean build environments per VM — no leftover dependencies
- Testing: Easy local testing — use local self-hosted agent for validation
- Compliance: Ideal for restricted environments — networking/security friendly
- Integration: Seamless DevOps integration — direct pool registration via PAT


##✅ Quick start checklist  
- Configure: Azure service connection and backend storage (if applicable)
- Create: Variable Group TerraformSecrets with required secrets
- Run: Execute the pipeline to provision → approve → de-register → destroy
- Verify: Check Azure DevOps Agent Pools for the new agent during the run

✨ Happy Automating with Terraform + Azure DevOps! 🚀


## ✍️ Authors

👨‍💻 **Vamshi Krishna**  
DevOps Engineer | DevOps & Kubernetes Enthusiast  

📫 Reach out on [GitHub](https://github.com/vamshii7)  | [LinkedIn](https://www.linkedin.com/in/vamshi7/)  
🌐 Focus Areas: Terraform, AKS, Azure DevOps, Kubernetes, and Cloud Automation  
🚀 Building hands-on labs for real-world learning!

> ⚙️ _Feel free to fork and contribute — PRs are welcome!_
