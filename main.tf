
module "network" {
  source = "./modules/network"
  availability_zone = var.availability_zone
  region = var.region
  subnet_cidr_public = "10.0.0.0/24"
  vpc_cidr = "10.0.0.0/16"
  tag = var.tag
}

module "ec2" {
  source = "./modules/ec2"
  availability_zone = var.availability_zone
  key_name = var.key_name
  region = var.region
  sg_pub_id = [module.network.sg_pub_id]
  s_pub_id = module.network.s_pub_id
  tag = var.tag
}

module "ssh-key" {
  source = "./modules/ssh-key"
  key_name = var.key_name
  tag = var.tag
}