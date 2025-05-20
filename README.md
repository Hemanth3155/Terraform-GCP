# Terraform-GCP

# Personal Website Deployment to GCP Storage with Terraform

This repository contains the configuration files for deploying a static personal website to Google Cloud Platform (GCP) using Terraform. It sets up Google Cloud Storage (GCS) to host the website and configures the necessary resources like storage buckets, IAM roles, and more.

# Prerequisites:

make sure to install following :

Terraform - Version 0.12 or higher

Google Cloud SDK - For interacting with GCP services

GCP Account - You need a Google Cloud account with appropriate permissions.

# Directory Structure:
```
Terraform-GCP/                    # Main directory for Terraform project
│
├── portfolio/                     # Website frontend files
│   ├── index.html                 # Main HTML file
│   ├── style.css                  # CSS file
│   ├── script.js                  # JavaScript (optional)
│   ├── profile.png                # Profile image or other images
│
├── infra/                         # Terraform infrastructure setup
│   ├── main.tf                    # Main Terraform configuration
│   ├── variables.tf               # Variable definitions
│   ├── terraform.tfvars           # Variable values (do not upload to GitHub)
│   ├── .gitignore                 # Ignore Terraform state files and sensitive data
│
├── screenshots/                   # Contains screenshots of the process
│
├── key.json                       # Service account key file (downloaded from GCP)
│
└── README.md                      # Project README file



# Steps:

1. create project in Google Cloud Console with the name you want.
2. enable the api's required for the project. 
   Compute Engine API
   Cloud Storage API
   Cloud CDN API
3. create a service account and make sure download the key file. and save it in the main folder.
4. create a folder shown in directory structure and write the code for terraform configuration in main.tf file and save it.
5. define variable in variable.tf. code will be like this:
variable "project" {
  description = "GCP project ID" 
  type        = string
}

variable "credentials_file" {
  description = "Path to the service account key"
  type        = string
}
6. create a terraform.tfva which you will enter the values of variables created in variable.tf. code will be:
project          = "name of your project"
credentials_file = "../keyname.json"(if you save in same directory)
7. open CLI in your local system and go to the folder where you saved the code. Then enter following commands:
terraform init
terraform plan
terraform apply
8. you will get output as a url of the storage bucket which created for personal website. then paste it browser you will see the website.
9. go to google cloud console and create cloud Loab Balancer and CDN. 
10. go to Load Balancer page and under frontend copy static IP.
11. go to your domain registry website with A record paste the IP in place of value and create a CNAME record with value bucketname.storage.googleapi.com. Example:

| Type  | Name | Value                               | TTL    |
| ----- | ---- | ----------------------------------- | ------ |
| A     | @    | `STATIC_IP_OF_YOUR_LOAD_BALANCER`   | 1 Hour |
| CNAME | www  | `bucketname.storage.googleapis.com` | 1 Hour |


12. create a google managed SSL certificate with your domain name. After creation enable port 443.
13. wait for dns to propagate and visit the domain name. you will see the website you have created.
14. then use command "terraform destroy" to destroy the resoucres with terraform and delete project in Google Cloud Console.