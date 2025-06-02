module "vpc" {
    source = "../vpc"
  
}
resource "aws_db_instance" "default" {
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  identifier        = var.identifier
  username          = var.username
  password          = var.password
  vpc_security_group_ids = [module.vpc.security_group_id]
  db_subnet_group_name   = module.vpc.my_db_subnet_group
  //aws_db_subnet_group.my_db_subnet_group.name

  backup_retention_period      = var.backup_retention_period
  backup_window                = var.backup_window
  maintenance_window           = var.maintenance_window
  skip_final_snapshot          = var.skip_final_snapshot
  final_snapshot_identifier    = var.final_snapshot_identifier
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  deletion_protection = var.deletion_protection
  storage_encrypted            = var.storage_encrypted
  kms_key_id                   = aws_kms_key.my_kms_key.arn
  db_name                      = var.db_name
  apply_immediately = var.apply_immediately

  parameter_group_name = aws_db_parameter_group.my_db_pmg.name

  # Enable Multi-AZ deployment for high availability
  multi_az = var.multi_az
}

resource "aws_db_instance_automated_backups_replication" "default" {
  source_db_instance_arn = aws_db_instance.default.arn
  retention_period       = var.retention_period
  kms_key_id = aws_kms_key.my_kms_key.arn

}

resource "aws_kms_key" "my_kms_key" {
  description             = "My KMS Key for RDS Encryption"
  deletion_window_in_days = 30

  tags = {
    Name = var.kms_key_id
  }
}

resource "aws_db_parameter_group" "my_db_pmg" {
  name   = "postgresql"
  family = "postgres14"

  parameter {
    name  = "autovacuum"
    value = 1
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = var.monitoring_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "rds_monitoring_attachment" {
  name       = "rds-monitoring-attachment"
  roles      = [aws_iam_role.rds_monitoring_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
