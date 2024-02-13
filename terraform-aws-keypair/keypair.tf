
resource "tls_private_key" "terrafrom_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  # Name of key : Write the custom name of your key
  key_name   = "aws_key_pair"
  # Public Key: The public will be generated using the reference of tls_private_key.terrafrom_generated_private_key
  public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh
  # Store private key :  Generate and save private key(aws_keys_pairs.pem) in current directory
  provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.terrafrom_generated_private_key.private_key_pem}' > aws_key_pair.pem
      chmod 400 aws_key_pair.pem
    EOT
  }
}


resource "aws_instance" "ec2_example" {
  ami           = "ami-06a0cd9728546d178"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-06351b6b6240765b2"]
  subnet_id              = "subnet-069e71a3fcbce63a6"
  # 2. Key Name
  # Specify the key name and it should match with key_name from the resource "aws_key_pair"
  key_name = var.aws_key_pair
  user_data = file("${path.module}/userdata.tpl")
  tags     = {
    Name = "Terraform EC2 - using tls_private_key module"
  }
  depends_on = [var.aws_key_pair]
}




variable "aws_key_pair" {
  type = any
}
