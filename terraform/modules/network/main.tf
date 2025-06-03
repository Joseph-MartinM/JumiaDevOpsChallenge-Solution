data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  #change accout_id
  owners = ["amazon"]

}

# ssh public key
resource "aws_key_pair" "devops-key" {
  key_name   = var.key_name
  public_key = file(var.public_key_location)
}


# Application EC2 Instance
resource "aws_instance" "application" {
  ami                    = data.aws_ami.ubuntu_ami.id
  key_name               = var.key_name
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone_names2
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.devops_public_subnet.id
  user_data              = file(var.user_data_location)

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.aws_key_pair)
  }

  tags = {
    Name = "App_Server"
  }

}

# Load Balancer EC2 Instance
resource "aws_instance" "load_balancer" {
  ami                    = data.aws_ami.ubuntu_ami.id
  key_name               = var.key_name
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone_names1
  vpc_security_group_ids = [aws_security_group.permit_web_traffic.id]
  subnet_id              = aws_subnet.devops_public_subnet.id
  user_data              = file(var.user_data_location)

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.aws_key_pair)
  }

  tags = {
    Name = "LoadBalancer_Server"
  }

}


#  /home/ec2-user/.ssh/my-key-pair
# i/home/ec2-user/.ssh/my-key-pair.pub

#app_instance = "51.20.66.197"
#db_instance = "13.51.178.195"
#lb_instance = "13.61.154.233"