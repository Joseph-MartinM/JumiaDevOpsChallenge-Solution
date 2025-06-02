output "my_db_subnet_group" {
  description = "Getting subnet group to be used by the rds db instance to created"
  value = aws_db_subnet_group.my_db_subnet_group.name
}

output "my_vpc" {

    description = "Getting vpc id to be used for creating sg"
    value = aws_vpc.my_vpc.id
  
}

output "security_group_id" {

    description = "Output security group id"
    value = aws_security_group.rds_sg.id
  
}

output "app_instance" {
  description = "Public IP of Application EC2 Instance"
  value       = aws_instance.application.public_ip

}

output "lb_instance" {
  description = "Public IP of Load Balancer EC2 Instance"
  value       = aws_instance.load_balancer.public_ip
}
output "devops_vpc" {
  description = "vpc Id"
  value = aws_vpc.my_vpc.id
  
}
output "db_subnet" {
  description = "Database subnet"
  value = aws_subnet.db_subnet
}
output "db_sg" {
  description = "Database security group"
  value = aws_security_group.rds_sg
  
}
