# Getting Started with Terraform and OCI (Oracle Cloud) Part 1: Creating Network Resources
[![Terraform](https://img.shields.io/badge/terraform-v1.3+-blue.svg)](https://www.terraform.io/downloads.html)

Blog --> https://gmusumeci.medium.com/getting-started-with-terraform-and-oci-oracle-cloud-part-1-creating-network-resources-800eb404c628

This code:

* Define the OCI Provider for Terraform
* Create a compartment
* Create a Virtual Cloud Network (VCN)
* Create Private and Public Subnets
* Deploy an Internet Gateway
* Deploy a NAT Gateway
* Create Route Tables
* Create DHCP Options

## How To deploy the code:

1. Clone the repo
2. Update the terraform.tfvars with the variables for your environment
3. Execute **terraform init**
4. Execute **terraform apply**

To destroy the environment, execute **terraform destroy**
