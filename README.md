# GP Terraform Foundation

A reusable and modular **Terraform Foundation Framework** for provisioning AWS infrastructure following Infrastructure as Code (IaC) best practices.

This project provides production-ready Terraform modules for commonly used AWS services, enabling teams to rapidly build cloud infrastructure with reusable components and isolated deployments.

---

# Features

* Modular Terraform architecture
* Reusable AWS infrastructure modules
* Independent root modules for each application or microservice
* Remote Terraform state support (Amazon S3)
* Easy to extend and maintain
* Environment-specific deployments
* Consistent naming and tagging strategy
* Production-ready module structure

---

# Repository Structure

```text
.
├── modules
│   ├── __cache
│   ├── __dynamodb
│   ├── __iam_policy
│   ├── __iam_role
│   ├── __rds
│   ├── __security_groups
│   ├── __sqs
│   ├── __vpc
│   └── security_group
│
└── terraform
    └── dev
        └── retail-store-app-aws
```

---

# Available Modules

| Module          | Description                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------- |
| VPC             | Creates VPC, subnets, route tables, Internet Gateway, NAT Gateway, and networking components      |
| RDS             | Creates Amazon RDS instances with configurable engine, storage, networking, and security          |
| DynamoDB        | Creates DynamoDB tables with support for TTL, Global Secondary Indexes, Streams, and encryption   |
| SQS             | Creates Amazon SQS queues with configurable visibility timeout, DLQ, FIFO support, and encryption |
| ElastiCache     | Creates Redis or Memcached clusters                                                               |
| Security Groups | Creates reusable security groups with configurable ingress and egress rules                       |
| IAM Roles       | Creates IAM Roles with trust policies                                                             |
| IAM Policies    | Creates reusable IAM policies and attaches them to IAM roles                                      |

---

# Architecture

```text
                  +------------------------+
                  | Root Module            |
                  | retail-store-app-aws   |
                  +-----------+------------+
                              |
        +---------------------+----------------------+
        |                     |                      |
        v                     v                      v
+---------------+    +----------------+     +-----------------+
| VPC Module    |    | Security Group |     | IAM Module      |
+---------------+    +----------------+     +-----------------+
        |                     |                      |
        +----------+----------+----------------------+
                   |
                   v
      +----------------------------------------------+
      | Application Infrastructure                   |
      |                                              |
      | • RDS                                        |
      | • DynamoDB                                   |
      | • SQS                                        |
      | • ElastiCache                                |
      +----------------------------------------------+

```

---

# Why This Framework?

Instead of writing Terraform code for every new project, this framework provides reusable infrastructure modules that can be shared across multiple applications and environments.

Benefits include:

* Less code duplication
* Faster infrastructure provisioning
* Standardized AWS deployments
* Easier maintenance
* Improved scalability
* Better collaboration across teams

---

# Remote State Management

Each application or microservice maintains its own isolated Terraform state.

Example:

```text
terraform-state/
├── retail-store-app
│   └── terraform.tfstate
├── carts
│   └── terraform.tfstate
├── orders
│   └── terraform.tfstate
└── catalog
    └── terraform.tfstate
```

This approach provides:

* Independent deployments
* Reduced risk of state conflicts
* Easier CI/CD integration
* Better team collaboration

---

# Example Usage

```hcl
module "carts_dynamodb" {

  source = "../../../..modules/__dynamodb"

  name         = "carts-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "customerId"
      type = "S"
    }
  ]
}
```

---

# Supported AWS Services

* Amazon VPC
* Amazon RDS
* Amazon DynamoDB
* Amazon SQS
* Amazon ElastiCache
* AWS IAM Roles
* AWS IAM Policies
* Amazon EC2 Security Groups

---

# Best Practices Followed

* Infrastructure as Code (IaC)
* DRY (Don't Repeat Yourself)
* Reusable Terraform Modules
* Environment Separation
* Remote State Management
* Modular Architecture
* Version Pinning
* Consistent Variable and Output Definitions
* Tagging Strategy
* Least Privilege IAM Design

---

# Future Enhancements

* Application Load Balancer Module
* Amazon Route 53 Module
* Amazon CloudFront Module
* AWS WAF Module
* AWS Lambda Module
* Amazon SNS Module
* Amazon EventBridge Module
* CI/CD GitHub Actions
* Automated Security Scanning
* Terraform Testing

---

# Prerequisites

* Terraform >= 1.6
* AWS CLI
* AWS Account
* Configured AWS Credentials

---

# Getting Started

Clone the repository:

```bash
git clone https://github.com/KarthikKunchala23/gp-terraform-foundation.git

cd gp-terraform-foundation
```

Initialize Terraform:

```bash
terraform init
```

Review the execution plan:

```bash
terraform plan
```

Deploy infrastructure:

```bash
terraform apply
```

---

# Contributing

Contributions are welcome!

If you have ideas for improvements, new modules, or bug fixes, feel free to open an issue or submit a pull request.

---

# License

This project is licensed under the MIT License.

---

# Author

**Karthik Raju Kunchala**

AWS DevOps & Platform Engineer

GitHub: https://github.com/KarthikKunchala23

---

⭐ If you find this project useful, consider giving it a star!
