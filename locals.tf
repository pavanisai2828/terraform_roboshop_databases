locals {
  databases={
    mongodb={
        sg_id= local.mongodb_sg_id
    }
    redis={
        sg_id= local.redis_sg_id
    }
    mysql={
        sg_id= local.mysql_sg_id
    }
    rabbitmq={
        sg_id= local.rabbitmq_sg_id
    }
  }
}

locals {
  mongodb_sg_id= data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id= data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id= data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq_sg_id=data.aws_ssm_parameter.rabbitmq_sg_id.value
  ami=data.aws_ami.join_devops.id
  database_subnet_id=split(",",data.aws_ssm_parameter.database_subnet_ids.value)[0]
}

locals {
  common_name="${var.Project}-${var.Environment}"
  common_tags={
    Project= var.Project
    Environment= var.Environment
    Terraform=true
  }
}
