resource "aws_db_instance" "jumiadb" {
  allocated_storage = 20
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  identifier = var.identifier
  username = var.username
  password = var.password

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

  backup_retention_period = var.backup_retention_period
  backup_window = var.backup_window
  maintenance_window = var.maintenance_window
  skip_final_snapshot = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_name.arn
  performance_insights_enabled = var.performance_insights_enabled
  # Enable storage encryption
  storage_encrypted = var.storage_encrypted
  # Specify the KMS key ID for encryption (replace with your own KMS key ARN)
  kms_key_id = aws_kms_key.my_kms_key.arn

  parameter_group_name = aws_db_parameter_group.my_db_pmg.name

  # Enable Multi-AZ deployment for high availability
  multi_az = var.multi_az
}
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

resource "aws_db_parameter_group" "my_db_pmg" {
  name = var.parameter_group_name
  family = "postgres9.6"

  parameter {
    name = "connect_timeout"
    value = "15"
  }

  # more parameters...
  # parameter {
    # name = "<parameter name>"
    # value = "<valid value>"
  # }
}

resource "aws_db_instance" "replica" {
  replicate_source_db = var.replicate_source_db
  instance_class = var.instance_class

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  backup_retention_period = var.backup_retention_period
  backup_window = var.backup_window
  maintenance_window = var.maintenance_window
  skip_final_snapshot = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.create_monitoring_role.arn
  performance_insights_enabled = var.performance_insights_enabled
  storage_encrypted = var.storage_encrypted
  kms_key_id = aws_kms_key.my_kms_key.arn

  parameter_group_name = aws_db_parameter_group.my_db_pmg.name

  # Enable Multi-AZ deployment for high availability
  multi_az = var.multi_az
}

resource "aws_db_instance_automated_backups_replication" "default" {
  source_db_instance_arn = var.source_db_instance_arn
  retention_period = var.retention_period
  kms_key_id = aws_kms_key.my_kms_key.arn

}




resource "aws_kms_key" "my_kms_key" {
  description = "My KMS Key for RDS Encryption"
  deletion_window_in_days = 30

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
