module "instance" {
  source       = "./terraform-aws-instance"
  aws_key_pair = module.key_pair.aws_key_pair
}

module "key_pair" {
  source = "./terraform-aws-keypair"
}