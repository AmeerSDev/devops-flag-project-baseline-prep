# Architecture Overview

## Target Topology (from assignment)
- 1× VPC
- 2× Private subnets
- 1× Public subnet
- 1× ELB (Application Load Balancer)
- 2× Linux EC2 instances in private subnets behind ALB
- 1× Bastion/Ansible host in public subnet
- Terraform state in S3 with DynamoDB locking

## Modules & Files
- Networking (`VPC`, `subnets`, `routes`) – see network‑related `*.tf`
- Security (`SGs`) – see `sg.tf`
- Compute (`EC2`) – see `EC2.tf`
- Load Balancer (`ALB`) – see `alb.tf`
- Backend state – `infra/terraform/envs/dev/backend.tf`

## Data flow
- `terraform apply` creates VPC + subnets + SGs + EC2 + ALB.
- `user-data.sh` bootstraps the web layer.
- Ansible (optional) can be run from the public host using `config/ansible` as needed.
