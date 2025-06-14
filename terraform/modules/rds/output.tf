output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.default.address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.default.arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = aws_db_instance.default.availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.default.endpoint
}

output "db_instance_engine" {
  description = "The database engine"
  value       = aws_db_instance.default.engine
}

output "db_instance_engine_version_actual" {
  description = "The running version of the database"
  value       = aws_db_instance.default.engine_version_actual
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = aws_db_instance.default.hosted_zone_id
}

output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.default.identifier
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = aws_db_instance.default.resource_id
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.default.status
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.default.db_name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.default.username
  sensitive   = true
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.default.port
}

output "db_instance_ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  value       = aws_db_instance.default.ca_cert_identifier
}
