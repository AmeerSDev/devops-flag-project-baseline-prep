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

