# Project Setup

# Serverless App - Pet-Cuddle-O-Tron

https://github.com/acantril/learn-cantrill-io-labs/tree/master/aws-serverless-pet-cuddle-o-tron

Welcome! This README will provide you with instructions on how to deploy Terraform infrastructure for Adrian Cantrill labs (https://github.com/acantril/learn-cantrill-io-labs)
We are going to implement a simple serverless application using S3, API Gateway, Lambda, Step Functions, SNS & SES.  

This project consists of 6 stages :-

- STAGE 1 : Configure Simple Email service 
- STAGE 2 : Add a email lambda function to use SES to send emails for the serverless application 
- STAGE 3 : Implement and configure the state machine, the core of the application
- STAGE 4 : Implement the API Gateway, API and supporting lambda function
- STAGE 5 : Implement the static frontend application and test functionality
- STAGE 6 : Cleanup the account


![Architecture](https://github.com/acantril/learn-cantrill-io-labs/raw/master/aws-serverless-pet-cuddle-o-tron/ArchitectureEvolutionAll.png)


### Clone the GitHub repo 

1. Clone the GitHub repository containing the app source code into the new folder using the `git clone` command:
```
git clone https://github.com/mohamed97-ba/agyla_labs_infra.git
```

### Run Terraform infrastructure

1. Install Terraform on your machine by following the official installation guide: [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

2. In your terminal/command prompt, navigate to the directory containing the Catpipeline Terraform configuration files (`.tf` files).
```
cd agyla_labs_infra/environments/dev
```

3. Initialize the Terraform working directory by running the following command:
```
terraform init
```

4. Verify the Terraform configuration by running the following command:
```
terraform validate
```

5. Review the execution plan by running the following command:
```
terraform plan
```

6. Apply the Terraform configuration by running the following command:
```
terraform apply --auto-approve
```

7. After the infrastructure has been successfully created, you can inspect the state by running the following command:
```
terraform show
```
