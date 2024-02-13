provider "aws" {
  region = "us-east-1"  # Choose your desired AWS region
}

resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"  # Replace with your desired AMI ID
  instance_type          = "t2.micro"
  key_name               = "your-key-pair-name"  # Replace with your key pair name
  subnet_id              = "your-subnet-id"  # Replace with your subnet ID
  associate_public_ip_address = true

  tags = {
    Name = "ExampleEC2Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              # Install Java
              yum install -y java-1.8.0-openjdk

              # Install wget
              yum install -y wget

              # Download and install Apache Tomcat
              wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.59/bin/apache-tomcat-9.0.59.tar.gz
              tar -xvf apache-tomcat-9.0.59.tar.gz -C /opt
              ln -s /opt/apache-tomcat-9.0.59 /opt/tomcat
              EOF
}

