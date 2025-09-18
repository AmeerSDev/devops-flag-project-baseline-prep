resource "tls_private_key" "KeyPairGeneration" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "PrivateKey" {
  content  = tls_private_key.KeyPairGeneration.private_key_pem
  filename = "${path.module}/KP.pem"
  file_permission = "0600"
}

# North_Virginia VM's Key Pair
resource "aws_key_pair" "North_VirginiaKP" {
  provider = aws.North_Virginia
  key_name   = "${var.name-prefix}-KeyPair"
  public_key = tls_private_key.KeyPairGeneration.public_key_openssh
}

# # Key Pair Copying from Terraform to Ansible Control VM
# resource "terraform_data" "Key_Pair_Copy" {
#   # Recreate this resource (and rerun provisioners) whenever the local key changes
#   triggers_replace = {
#     key_checksum = sha256(file("${path.module}/KP.pem"))
#   }

#   # One connection for all provisioners
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = tls_private_key.KeyPairGeneration.private_key_pem
#     host        = aws_instance.North_Virginia-Public1-VM.public_ip
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "mkdir -p /home/ubuntu/",
#       "chmod 700 /home/ubuntu/",
#       "chown ubuntu:ubuntu /home/ubuntu/"
#     ]
#   }

#   provisioner "file" {
#     source      = "${path.module}/KP.pem"
#     destination = "/home/ubuntu/KP.pem"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod 600 /home/ubuntu/KP.pem",
#       "chown ubuntu:ubuntu /home/ubuntu/KP.pem"
#     ]
#   }

# }

