##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################


resource "aws_security_group_rule" "allow-workers-nodes-communications" {
  description              = "Allow worker nodes to communicate with database"
  from_port                = 5432
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sec_grp_rds.id}"
  source_security_group_id = "${aws_security_group.worker_group_mgmt_one.id}"
  to_port                  = 5432
  type                     = "ingress"
}

#####
# DB
#####
module "db" {
  version = "~> 2.0"
  source  = "terraform-aws-modules/rds/aws"

  identifier = "${module.eks.cluster_id}"

  engine              = "${var.rds_engine}"
  engine_version       = "${var.rds_engine_version}"
  major_engine_version = "${var.db_major_engine_version}"
  instance_class      = "${var.rds_instance_class}"
  allocated_storage   = "${var.rds_allocated_storage}"
  multi_az            = true
  storage_encrypted   = false
  publicly_accessible = true

  name = "${var.rds_name}"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = "${var.rds_username}"

  password = "${var.rds_password}"
  port     = "${var.rds_port}"

  vpc_security_group_ids = [aws_security_group.sec_grp_rds.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  # DB subnet group
  subnet_ids = "${module.vpc.private_subnets}"

  # DB parameter group
  family = "${var.rds_parameter_group_family}"
}
