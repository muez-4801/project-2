Project 2: CloudScale Container Deployment with Terraform & GitHub Actions CI/CD
By : 
Muez Fathy - 4801
Mohamed Bengdara - 4909
Eslam Al Madany - 5074

An automated, highly scalable cloud infrastructure deployment featuring a containerized web application hosted on Azure Container Instances (ACI). The entire lifecycle is managed using Terraform for Infrastructure as Code (IaC) and GitHub Actions for the Continuous Integration and Continuous Deployment (CI/CD) pipeline, incorporating a production environment gate with manual approval.

🏗️ Project Architecture

The architecture consists of the following cloud-native components deployed securely on Microsoft Azure:

+----------------------------------------------------------------------------------+
|                                  Microsoft Azure                                 |
|                                                                                  |
|  +--------------------+      +--------------------+      +--------------------+  |
|  |   Resource Group   | ---> |  Storage Account   | ---> |    Blob Container  |  |
|  | (terraform-state-r)|      |   (tfstatexxxxx)   |      |      (tfstate)     |  |
|  +--------------------+      +--------------------+      +--------------------+  |
|                                                                    |             |
|                                                     Stores Remote State File     |
|                                                                    v             |
|  +--------------------+      +--------------------+      +--------------------+  |
|  |   Resource Group   | ---> |  Container Group   | ---> |  Web App (Port 80) |  |
|  | (project2-rg-sc)   |      |  (swedencentral)   |      | (Custom HTML Page) |  |
|  +--------------------+      +--------------------+      +--------------------+  |
+----------------------------------------------------------------------------------+


Remote Backend Storage: An Azure Storage Account and Container (tfstate) created within the terraform-state-rg resource group. This securely persists the Terraform state file (project2.tfstate) outside the local developer machine to facilitate team collaboration.

Compute Service: An Azure Container Instance (ACI) hosting the custom web application container.

Network Configurations: Public IP allocation with fully qualified domain name (FQDN) registration, exposing Port 80 to the public internet.

Geographic Policy Bypass: Configured specifically for deployment in Sweden Central (swedencentral) to adhere to university subscription location constraints.

📁 Repository Structure

├── .github/
│   └── workflows/
│       └── terraform.yml       # GitHub Actions workflow (Plan & Apply)
├── app/
│   ├── index.html              # Custom Web App HTML (Updated with Team Names & IDs)
│   └── ...                     # Static styling/assets for index.html
├── Dockerfile                  # Instructions to package the app inside Nginx
├── main.tf                     # Core Terraform infrastructure resources (ACI)
├── providers.tf                # Provider configurations & Remote Azure Backend
├── variables.tf                # Parameter declarations (Region, Docker Image, etc.)
└── outputs.tf                  # Infrastructure outputs (IP address, FQDN URL)


📋 Prerequisites & Tools

Before running this project, ensure you have the following installed and configured:

Visual Studio Code (VS Code)

Git (Configured locally with your GitHub credentials)

Docker Desktop (With a free Docker Hub account)

Azure CLI

Terraform CLI (v1.6.0+)

🛠️ Step-by-Step Implementation Guide

1. Build and Push the Docker Container

The custom web application runs inside a lightweight, highly optimized Nginx container.

From your VS Code Terminal:

# Log in to your Docker Hub account
docker login

# Build your custom Docker container 
docker build -t your_dockerhub_username/cloudscale-app:v1 .

# Push your image to Docker Hub
docker push your_dockerhub_username/cloudscale-app:v1


2. Configure Terraform Local Variables

Open variables.tf and edit the default values to reflect your environments:

location: Set to "swedencentral" (Sweden Central region) to align with subscription compliance.

docker_image: Set to your pushed Docker Hub image (your_dockerhub_username/cloudscale-app:v1).

Open providers.tf and input your unique storage account name:

storage_account_name: Update with the unique tfstate%RANDOM% storage account name created in Azure.

3. Local Verification (Dry-Run)

Authenticate your VS Code terminal and test the configuration:

# Log in to the target subscription
az login --tenant 4fe2d575-cf04-436d-9781-64d8a5907409

# Fetch and secure access to your state storage account
set ARM_ACCESS_KEY=your_retrieved_storage_account_key

# Initialize and preview deployment
terraform init -reconfigure
terraform plan


🚀 GitHub Actions CI/CD Pipeline

The integration and deployment processes are fully automated using a multi-stage GitHub Actions workflow.

Required GitHub Repository Secrets

Navigate to Settings -> Secrets and variables -> Actions in your GitHub repo and configure the following variables:

AZURE_CLIENT_ID: Your Azure Service Principal Application ID.

AZURE_CLIENT_SECRET: Your Azure Service Principal Secret Key.

AZURE_TENANT_ID: Your Directory Tenant ID.

AZURE_SUBSCRIPTION_ID: Your Target Azure Subscription ID.

Pipeline Stages

Pull Request Trigger:

Runs Terraform Init and Terraform Plan as an automated check on any pull request targeting the main branch.

This provides a risk-free review of what infrastructure will change.

Merge / Push Trigger (Production Deployment):

Triggers on a direct push or merge to the main branch.

Prompts the Manual Approval Gate requiring a review from designated repository collaborators.

Once approved, runs Terraform Apply to provision the containerized environment on Azure.

🧹 Infrastructure Cleanup

To prevent ongoing consumption of your Azure student credit balance, tear down the container deployment once evaluated:

# Destroy cloud-hosted compute instances
terraform destroy -auto-approve
