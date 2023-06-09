# --- Common ------------------------------------------------------------------
variable "name" {
  type        = string
  description = "The name of the web backend."
}

# --- VPC ---------------------------------------------------------------------
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC into which the web backend is placed."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of IDs of private subnets into which ASG instances are placed."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of IDs of public subnets into which the ALB is placed."
}

variable "database_subnet_ids" {
  type        = list(string)
  description = "A list of IDs of database subnets into which the database is placed."
}

# --- Bastion -----------------------------------------------------------------
variable "bastion_sg_id" {
  type        = string
  description = "The ID of the bastion Security Group."
}

# --- ASG ---------------------------------------------------------------------
variable "ami_id" {
  type        = string
  description = "The ID of the ASG instance AMI."
}

variable "asg_min_size" {
  type        = number
  description = "The minimum number of instances in the ASG."
  default     = 1
}

variable "asg_max_size" {
  type        = number
  description = "The maximum number of instances in the ASG."
  default     = 1
}

variable "asg_desired_capacity" {
  type        = number
  description = "The desired number of instances in the ASG."
  default     = 1
}

variable "asg_instance_type" {
  type        = string
  description = "The instance type of instances in the ASG."
  default     = "t3.micro"
}

variable "asg_instance_profile_name" {
  type        = string
  description = "The name of the instance profile attached to instances in the ASG."
}

variable "asg_user_data_template" {
  type        = string
  description = "The template file used to generate user data injected into the instances in the ASG."
}

# --- ALB ---------------------------------------------------------------------
variable "route53_zone_id" {
  type        = string
  description = "The Route 53 Zone ID."
}

variable "fqdn" {
  type        = string
  description = "The FQDN of the web backend."
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "A list of subject alternative names."
  default     = []
}

# --- RDS ---------------------------------------------------------------------
variable "rds_port" {
  type        = string
  description = "The port on which RDS is made available."
  default     = "5432"
}

variable "rds_db_name" {
  type        = string
  description = "The name of the database in the RDS instance."
}

variable "rds_username" {
  type        = string
  description = "The name of the user in the RDS instance."
}

variable "rds_password" {
  type        = string
  description = "The password of the user in the RDS instance."
}

variable "rds_allocated_storage" {
  type        = number
  description = "The amount of storage allocated (in GB) for the RDS instance."
  default     = 10
}

variable "rds_engine" {
  type        = string
  description = "The database engine of the RDS instance."
  default     = "postgres"
}

variable "rds_engine_version" {
  type        = string
  description = "The version of the database engine of the RDS instance."
  default     = "14.6"
}

variable "rds_maintenance_window" {
  type        = string
  description = "The maintenance window for the RDS instance."
  default     = "Mon:00:00-Mon:03:00"
}

variable "rds_backup_window" {
  type        = string
  description = "The backup window for the RDS instance."
  default     = "03:00-06:00"
}

variable "rds_backup_retention_period" {
  type        = number
  description = "The number of days for which backups of the RDS instance are retained."
  default     = 7
}

variable "rds_family" {
  type        = string
  description = "The family of the database engine of the RDS instance."
  default     = "postgres14"
}

variable "rds_major_engine_version" {
  type        = string
  description = "The major version of the database engine of the RDS instance."
  default     = "14"
}

variable "rds_instance_class" {
  type        = string
  description = "The instance class of the RDS instance."
  default     = "db.t3.micro"
}
