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

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  type        = string
  default     = "rds-monitoring-role"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "5432"
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = "jumiaKey"
}
