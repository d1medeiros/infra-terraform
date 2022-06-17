data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
  tags = {
    action = var.tag
  }
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  associate_public_ip_address = var.associate_public_ip_address
  get_password_data = false
  source_dest_check = true
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
#  provisioner "file" {
#    source      = "./${var.key_name}.pem"
#    destination = "/home/ec2-user/${var.key_name}.pem"
#    connection {
#      type        = "ssh"
#      user        = "ec2-user"
#      private_key = file("${var.key_name}.pem")
#      host        = self.public_ip
#    }
#  }
#  provisioner "remote-exec" {
#    inline = ["chmod 400 ~/${var.key_name}.pem"]
#    connection {
#      type        = "ssh"
#      user        = "ec2-user"
#      private_key = file("${var.key_name}.pem")
#      host        = self.public_ip
#    }
#  }
  tags = {
    action = var.tag
  }
}