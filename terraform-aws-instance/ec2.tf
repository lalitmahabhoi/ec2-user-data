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