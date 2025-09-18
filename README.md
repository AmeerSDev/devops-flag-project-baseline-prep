# Cloud Lab – Terraform + Ansible

This repository provisions a complete AWS environment using **Terraform** for infrastructure and **Ansible** (optional) for configuration management.  

The environment includes:  
- 1× **VPC**  
- 2× **Private Subnets**  
- 1× **Public Subnet**  
- 1× **Application Load Balancer (ALB)**  
- 2× **EC2 Linux instances** in private subnets (behind the ALB)  
- 1× **Bastion/Ansible host** in the public subnet  
- **Terraform backend** stored in **S3 + DynamoDB**  

---

## 📂 Repository Structure

```
infra/
  terraform/
    EC2.tf              # EC2 instance definitions
    alb.tf              # Application Load Balancer
    network.tf          # VPC, subnets, routes
    sg.tf               # Security groups
    keypair.tf          # Key pair resource
    providers.tf        # AWS provider
    variables.tf        # Input variables
    outputs.tf          # Outputs
    envs/
      dev/
        backend.tf      # Backend state config (S3 + DynamoDB)
    files/
      user-data.sh      # Bootstrap script for EC2
config/
  ansible/
      user-data-ansible.sh # script to deploy the midterm project
docs/
  ARCHITECTURE.md       # High-level system overview
scripts/
  destroy-all.sh        # Helper to destroy all resources
```

---

## 🚀 Getting Started

### 1. Prerequisites
- AWS account with programmatic access  
- Terraform >= 1.5 installed  
- Ansible >= 2.15 (optional, for playbook execution)  
- An existing AWS **key pair** (for SSH access to EC2)  

### 2. Backend Setup
Edit `infra/terraform/envs/dev/backend.tf` and provide:  
- S3 bucket name  
- DynamoDB table name  
- Region  

These must exist in your AWS account before running `terraform init`.

### 3. Variables
Main variables are defined in `infra/terraform/variables.tf`:  

- `aws_region` → Deployment region (e.g., `eu-central-1`)  
- `key_pair_name` → Name of an existing EC2 key pair  
- `my_ip_cidr` → Your IP in CIDR notation for SSH (e.g., `1.2.3.4/32`)  
- `instance_type` → EC2 instance type (default: `t2.micro`)  

You can set them using a `terraform.tfvars` file or via CLI:  
```hcl
aws_region    = "eu-central-1"
key_pair_name = "your-key-name"
my_ip_cidr    = "X.X.X.X/32"
```

### 4. Deploy
From the `infra/terraform` directory:  
```bash
terraform init -backend-config="key=dev/terraform.tfstate"
terraform plan -out tfplan
terraform apply tfplan
```

### 5. Access the App
- Terraform outputs will show the **ALB DNS name**.  
- Open it in your browser → you should see the web app served by the private EC2 instances.  

### 6. Destroy
To clean up:  
```bash
./scripts/destroy-all.sh
```

---

## 🛠️ Ansible (Optional)
After Terraform provisions the infrastructure, you may configure servers using Ansible:  

1. Update `config/ansible/inventory/` with your EC2 public/private IPs.  
2. Run:  
   ```bash
   cd config/ansible
   ansible-playbook -i inventory playbooks/site.yml
   ```

---

## 📖 Notes
- The bootstrap script (`infra/terraform/files/user-data.sh`) can be customized to install your **Python web server** and mid-project app code.  
- All `.tf` files are documented with inline comments for clarity.  
- The design follows the assignment requirements: VPC, subnets, ELB, EC2s, Ansible host, and state backend.  

---

✨ This repository is clean, modular, and ready to demonstrate full DevOps workflow: **Infrastructure as Code + Configuration Management**.
