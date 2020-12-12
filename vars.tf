###################CLUSTER VARIABLES##################
variable "region" {
  default = "us-east-1"
}

variable "cidr" {
   default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "private_subnets" {
  type = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "vpc_name" {
  default = "leafsheets_dev-vpc"
}
variable "aws_key_pair" {
   default = "leafsheets-prod"
}

###################RDS VARIABLES##################
variable "rds_name" {
  default = "dev"
}

variable "rds_port" {
  default = "5432"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_allocated_storage" {
  default = "20"
}

variable "rds_engine" {
  default = "postgres"
}

variable "rds_engine_version" {
  default = "11.8"
}
variable "db_major_engine_version" {
  default = "11"
}
variable "rds_instance_class" {
  default = "db.t2.small"
}

variable "rds_username" {
  default = "postgres"
}

variable "rds_password" {
  default = "postgres"
}

variable "rds_parameter_group_family" {
  default = "postgres11"
}
variable "enable_dashboard" {
  default = true
}
