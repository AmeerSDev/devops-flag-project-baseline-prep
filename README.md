# Cloud Lab – Terraform + Ansible (Refactored Structure)

This repository reorganizes the project into clear, assignment‑friendly folders **without changing core functionality**.
Use Terraform to provision the environment and Ansible (or cloud-init user data) to configure the web app.

## Repository layout
```
infra/
  terraform/
    envs/
      dev/
        backend.tf          # S3 + DynamoDB backend (provide your bucket/table)
    files/
      user-data.sh          # EC2 bootstrap script (moved here)
    *.tf                     # providers, variables, network, sg, ec2, alb, outputs, etc.
config/
  ansible/
    inventory/               # place your inventory here if needed
    playbooks/
      site.yml               # example playbook (optional)
docs/
  ARCHITECTURE.md           # high-level overview (this file)
scripts/
  destroy-all.sh            # helper to destroy infra safely
README_ORIGINAL.md          # the original README from your zip (kept for reference)
```

## How to run
1. Export AWS credentials (or use your local profile).
2. Set the backend (edit `infra/terraform/envs/dev/backend.tf`).
3. From `infra/terraform`, run:
   ```bash
   terraform init -backend-config="key=dev/terraform.tfstate"
   terraform plan -out tfplan
   terraform apply tfplan
   ```
4. When finished:
   ```bash
   terraform destroy -auto-approve
   ```

## Notes
- Paths to the bootstrap script were updated to `files/user-data.sh`.
- Resource definitions and logic remain the same; only structure/paths changed.
- Ensure the S3 bucket and DynamoDB table from `backend.tf` exist (or let Terraform create them if configured so).
