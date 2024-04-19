resource "aws_rds_cluster" "default" {
  depends_on          = [aws_rds_cluster_parameter_group.default, aws_db_subnet_group.default]
  for_each = var.rds
  cluster_identifier  = "${var.env}-${each.key}-roboshop-rds"
  engine              = var.engine
  engine_version      = var.engine_version
  database_name       = "mydb"
  master_username     = ""
  master_password     = ""
  skip_final_snapshot = true
  db_cluster_parameter_group_name = "${var.env}-${each.key}-roboshop-rds"
  db_subnet_group_name   = "${var.env}-${each.key}-roboshop-rds"
#  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_rds_cluster_parameter_group" "default" {
  for_each = var.rds
  name        = "${var.env}-${each.key}-roboshop-rds"
  family      = "aurora5.6"
  description = "RDS default cluster parameter group"
}

resource "aws_db_subnet_group" "default" {
  for_each = var.rds
  name       = "${var.env}-${each.key}-roboshop-rds"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${each.key}-roboshop-rds"
  }
}