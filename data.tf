data "aws_ssm_parameter" "mongodb_sg_id" {
    name="/${var.Project}/${var.Environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
    name="/${var.Project}/${var.Environment}/redis_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
    name="/${var.Project}/${var.Environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name="/${var.Project}/${var.Environment}/rabbitmq_sg_id"
}

data "aws_ami" "join_devops" {
    most_recent = true
    owners = ["973714476881"]

    filter {
        name= "name"
        values = ["Redhat-9-DevOps-Practice"]
        }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
        }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
}

data "aws_ssm_parameter" "database_subnets" {
    name="/${var.Project}/${var.Environment}/database_subnets"
}
