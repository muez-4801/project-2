Project 2: CloudScale Container Deployment with Terraform & GitHub Actions CI/CD

An automated, highly scalable cloud infrastructure deployment featuring a containerized web application hosted on Azure Container Instances (ACI). The entire lifecycle is managed using Terraform for Infrastructure as Code (IaC) and GitHub Actions for the Continuous Integration and Continuous Deployment (CI/CD) pipeline, incorporating a production environment gate with manual approval.

 Project Architecture

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
