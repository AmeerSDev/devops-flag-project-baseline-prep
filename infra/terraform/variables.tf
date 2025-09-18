# Insert Relevant AWS ACCESS KEY VALUE FROM AWS LAB
variable "aws_access_key_id" {
  description = "Access Key" 
  type = string
  default = ""
}

# Insert Relevant AWS SECRET KEY VALUE FROM AWS LAB
variable "aws_secret_access_key" {
  description = "Secret Key" 
  type = string
  default = ""
}

# Insert Relevant AWS SESSION TOKEN VALUE FROM AWS LAB
variable "aws_session_token" {
  description = "Session Token" 
  type = string
  default = ""
}

# VPC Region Prefix Name
variable "name-prefix" {
  description = "Name Prefix"
  type = string
  default = "North_Virginia"
}

# AMI Image for Ubuntu EC2 Instances
variable "ami" {
  description = "AMI For Region North_Virginia"
  type = string
  default = "ami-0360c520857e3138f" # Ubuntu Server 224.04 LTS (HVM), SSD Volume Type
}

# VM Instance Size
variable "vm-size" {
  description = "VM Size"
  type = string
  default = "t3.small"
}

# VPC CIDR Block
variable "vpc-cidr" {
  description = "VPC Cidr"
  type = string
  default = "10.10.0.0/16"
}

# Public 1 Subnet Block
variable "vpc-public-subnet-1" {
  description = "VPC Public Subnet 1"
  type = string
  default = "10.10.1.0/24"
}

# Public 2 Subnet Block
variable "vpc-public-subnet-2" {
  description = "VPC Public Subnet 2"
  type = string
  default = "10.10.0.0/24"
}

# Private 1 Subnet Block
variable "vpc-private-subnet-1" {
  description = "VPC Private Subnet 1"
  type = string
  default = "10.10.2.0/24"
}

# Private 2 Subnet Block
variable "vpc-private-subnet-2" {
  description = "VPC Private Subnet 2"
  type = string
  default = "10.10.3.0/24"
}

# Your IP Address (Temporarity Deprecated/Not in Use)
variable "ip-address" {
  description = "Your IP Address"
  type = string
  default = "93.157.83.42/32"
}

# Ansible User-Data .sh file
locals {
  ansible_install_user_data = file("${path.module}/../ansible/files/user-data.sh")
}
