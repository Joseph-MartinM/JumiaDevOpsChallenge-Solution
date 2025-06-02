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
  value = aws_vpc.devops_vpc.id
  
}
output "db_subnet" {
  description = "Database subnet"
  value = aws_subnet.db_subnet
}
output "db_sg" {
  description = "Database security group"
  value = aws_security_group.db_sg
  
}