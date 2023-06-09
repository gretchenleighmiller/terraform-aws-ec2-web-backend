## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | n/a |
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_cert"></a> [cert](#module\_cert) | terraform-aws-modules/acm/aws | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-aws-modules/rds/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.asg_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.db_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.asg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.asg_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.asg_ssh_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The ID of the ASG instance AMI. | `string` | n/a | yes |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | The desired number of instances in the ASG. | `number` | `1` | no |
| <a name="input_asg_instance_profile_name"></a> [asg\_instance\_profile\_name](#input\_asg\_instance\_profile\_name) | The name of the instance profile attached to instances in the ASG. | `string` | n/a | yes |
| <a name="input_asg_instance_type"></a> [asg\_instance\_type](#input\_asg\_instance\_type) | The instance type of instances in the ASG. | `string` | `"t3.micro"` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | The maximum number of instances in the ASG. | `number` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | The minimum number of instances in the ASG. | `number` | `1` | no |
| <a name="input_asg_user_data_template"></a> [asg\_user\_data\_template](#input\_asg\_user\_data\_template) | The template file used to generate user data injected into the instances in the ASG. | `string` | n/a | yes |
| <a name="input_bastion_sg_id"></a> [bastion\_sg\_id](#input\_bastion\_sg\_id) | The ID of the bastion Security Group. | `string` | n/a | yes |
| <a name="input_database_subnet_ids"></a> [database\_subnet\_ids](#input\_database\_subnet\_ids) | A list of IDs of database subnets into which the database is placed. | `list(string)` | n/a | yes |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | The FQDN of the web backend. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the web backend. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | A list of IDs of private subnets into which ASG instances are placed. | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | A list of IDs of public subnets into which the ALB is placed. | `list(string)` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | The amount of storage allocated (in GB) for the RDS instance. | `number` | `10` | no |
| <a name="input_rds_backup_retention_period"></a> [rds\_backup\_retention\_period](#input\_rds\_backup\_retention\_period) | The number of days for which backups of the RDS instance are retained. | `number` | `7` | no |
| <a name="input_rds_backup_window"></a> [rds\_backup\_window](#input\_rds\_backup\_window) | The backup window for the RDS instance. | `string` | `"03:00-06:00"` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | The name of the database in the RDS instance. | `string` | n/a | yes |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | The database engine of the RDS instance. | `string` | `"postgres"` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | The version of the database engine of the RDS instance. | `string` | `"14.6"` | no |
| <a name="input_rds_family"></a> [rds\_family](#input\_rds\_family) | The family of the database engine of the RDS instance. | `string` | `"postgres14"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance class of the RDS instance. | `string` | `"db.t3.micro"` | no |
| <a name="input_rds_maintenance_window"></a> [rds\_maintenance\_window](#input\_rds\_maintenance\_window) | The maintenance window for the RDS instance. | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_rds_major_engine_version"></a> [rds\_major\_engine\_version](#input\_rds\_major\_engine\_version) | The major version of the database engine of the RDS instance. | `string` | `"14"` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | The password of the user in the RDS instance. | `string` | n/a | yes |
| <a name="input_rds_port"></a> [rds\_port](#input\_rds\_port) | The port on which RDS is made available. | `string` | `"5432"` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | The name of the user in the RDS instance. | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | The Route 53 Zone ID. | `string` | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | A list of subject alternative names. | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC into which the web backend is placed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the ALB. |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | The ARN suffix of the ALB. |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the ALB. |
| <a name="output_alb_id"></a> [alb\_id](#output\_alb\_id) | The ID of the ALB. |
| <a name="output_alb_sg_id"></a> [alb\_sg\_id](#output\_alb\_sg\_id) | The ID of the ALB Security Group. |
| <a name="output_asg_arn"></a> [asg\_arn](#output\_asg\_arn) | The ARN of the ASG. |
| <a name="output_asg_id"></a> [asg\_id](#output\_asg\_id) | The ID of the ASG. |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | The name of the ASG. |
| <a name="output_asg_sg_id"></a> [asg\_sg\_id](#output\_asg\_sg\_id) | The ID of the ASG Security Group. |
| <a name="output_db_arn"></a> [db\_arn](#output\_db\_arn) | The ARN of the RDS instance. |
| <a name="output_db_az"></a> [db\_az](#output\_db\_az) | The availability zone of the RDS instance. |
| <a name="output_db_host"></a> [db\_host](#output\_db\_host) | The host of the RDS instance. |
| <a name="output_db_id"></a> [db\_id](#output\_db\_id) | The ID of the RDS instance. |
| <a name="output_db_sg_id"></a> [db\_sg\_id](#output\_db\_sg\_id) | The ID of the database Security Group. |
