variable "region" {
  description = "Us region to be sued by the provider"  
  type = string
  default = "us-east-1"

}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "5432"
}

# Project Name
variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "DevOps_Challenge"

}

variable "availability_zone_names1" {
  type    = string
  default = "us-east-1a"
}

variable "availability_zone_names2" {
  type    = string
  default = "us-east-1b"
}

variable "availability_zone_names3" {
  type    = string
  default = "us-east-1c"
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
