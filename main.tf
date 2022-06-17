
module "network" {
  source = "./modules/network"
  availability_zone = var.availability_zone
  region = var.region
  subnet_cidr_public = "10.0.0.0/24"
  subnet_cidr_private = "10.0.1.0/24"
  vpc_cidr = "10.0.0.0/16"
  tag = var.tag
}

module "ec2-public" {
  source = "./modules/ec2"
  availability_zone = var.availability_zone
  key_name = var.key_name
  region = var.region
  associate_public_ip_address = true
  subnet_id = module.network.s_pub_id
  vpc_security_group_ids = [module.network.sg_pub_id]
  tag = var.tag
}

module "ec2-private" {
  source = "./modules/ec2"
  availability_zone = var.availability_zone
  key_name = var.key_name
  region = var.region
  subnet_id = module.network.s_pri_id
  vpc_security_group_ids = [module.network.sg_pub_id]
  tag = var.tag
}

#module "ssh-key" {
#  source = "./modules/ssh-key"
#  key_name = var.key_name
#  tag = var.tag
#}