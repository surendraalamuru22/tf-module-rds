resource "aws_rds_cluster" "default" {
  depends_on          = [aws_db_subnet_group.default]
  cluster_identifier  = "${var.env}-${var.name}-roboshop-rds"
  engine              = var.engine
  engine_version      = var.engine_version
  database_name       = "mydb"
  master_username     = "admin1"
  master_password     = "aheqrova"
  skip_final_snapshot = var.skip_final_snapshot
#  db_cluster_parameter_group_name = "${var.env}-${var.name}-roboshop-rds"
  db_subnet_group_name   = "${var.env}-${var.name}-roboshop-rds"
#  vpc_security_group_ids = [aws_security_group.sg.id]
}

#resource "aws_rds_cluster_parameter_group" "default" {
#  name        = "${var.env}-${var.name}-roboshop-rds"
#  family      = "aurora5.6"
#  description = "RDS default cluster parameter group"
#}

resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-${var.name}-roboshop-rds"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${var.name}-roboshop-rds"
  }
}