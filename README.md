# ua92-terraform-intro
This terrafrom code provisions an ECS container and the supporting networking for it. This includes an application load balance, security groups, VPC, route tables and subnets

## Pre-Requisites
- S3 bucket to store your statefile
- IAM User access keys with EC2, ECS, S3 and VPC permissions