# Project Name
variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "DevOps_Challenge"

}

variable "availability_zone_names" {
  type    = string
  default = "eu-north-1a"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.medium"
}

#AWS Key
variable "aws_key_pair" {
  default = "/home/ec2-user/.ssh/my-key-pair.pem"
}

variable "key_name" {
  description = "Name of the private key to used for SSH"
  type        = string
  default     = "my-key-pair"

}
