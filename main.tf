# --- ALB Security Group ------------------------------------------------------
resource "aws_security_group" "alb_sg" {
  name        = "${local.snake_case_name}_alb_sg"
  description = "${var.name} ALB Security Group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  description       = "Allow HTTP ingress from all"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  description       = "Allow HTTPS ingress from all"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  description       = "Allow all egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.alb_sg.id
}

# --- ASG Security Group ------------------------------------------------------
resource "aws_security_group" "asg_sg" {
  name        = "${local.snake_case_name}_asg_sg"
  description = "${var.name} ASG Security Group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "asg_http_ingress" {
  type                     = "ingress"
  description              = "Allow HTTP ingress from ALB"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.asg_sg.id
}

resource "aws_security_group_rule" "asg_ssh_ingress" {
  type                     = "ingress"
  description              = "Allow SSH ingress from bastion"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id        = aws_security_group.asg_sg.id
}

resource "aws_security_group_rule" "asg_egress" {
  type              = "egress"
  description       = "Allow all egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.asg_sg.id
}

# --- RDS Security Group ------------------------------------------------------
resource "aws_security_group" "db_sg" {
  name        = "${local.snake_case_name}_db_sg"
  description = "${var.name} database Security Group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "db_ingress" {
  type                     = "ingress"
  description              = "Allow database ingress from ASG"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.asg_sg.id
  security_group_id        = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "db_egress" {
  type              = "egress"
  description       = "Allow all egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.db_sg.id
}

# --- ASG ---------------------------------------------------------------------
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "${local.kebab_case_name}-asg"

  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_desired_capacity
  health_check_type   = "EC2"
  vpc_zone_identifier = var.private_subnet_ids

  image_id          = var.ami_id
  instance_type     = var.asg_instance_type
  enable_monitoring = false

  launch_template_name        = local.kebab_case_name
  launch_template_description = "${var.name} launch template"
  update_default_version      = true

  target_group_arns = module.alb.target_group_arns
  security_groups   = [aws_security_group.asg_sg.id]

  iam_instance_profile_name = var.asg_instance_profile_name
  user_data                 = base64encode(templatefile(var.asg_user_data_template, {}))

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 0
    }
    triggers = ["launch_configuration"]
  }

  tags = {
    Type = local.snake_case_name
  }
}

# --- ALB ---------------------------------------------------------------------
module "cert" {
  source = "terraform-aws-modules/acm/aws"

  domain_name = var.fqdn
  zone_id     = var.route53_zone_id

  subject_alternative_names = var.subject_alternative_names

  wait_for_validation = true
}

module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "${local.kebab_case_name}-alb"

  load_balancer_type = "application"

  vpc_id                = var.vpc_id
  subnets               = var.public_subnet_ids
  create_security_group = false
  security_groups       = [aws_security_group.alb_sg.id]

  target_groups = [
    {
      name             = local.kebab_case_name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = 443
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.cert.acm_certificate_arn
      target_group_index = 0
    }
  ]
}

resource "aws_route53_record" "a" {
  for_each = toset(local.domain_aliases)

  zone_id = var.route53_zone_id
  name    = each.key
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = false
  }
}

# --- RDS ---------------------------------------------------------------------
module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.kebab_case_name

  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  family               = var.rds_family
  major_engine_version = var.rds_major_engine_version
  instance_class       = var.rds_instance_class

  allocated_storage = var.rds_allocated_storage
  storage_encrypted = true

  create_random_password = false

  db_name  = var.rds_db_name
  username = var.rds_username
  password = var.rds_password
  port     = var.rds_port

  maintenance_window      = var.rds_maintenance_window
  backup_window           = var.rds_backup_window
  backup_retention_period = var.rds_backup_retention_period

  subnet_ids             = var.database_subnet_ids
  create_db_subnet_group = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
