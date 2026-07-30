locals {
  databases={
    mongodb={
        sg_id= local.mongodb_sg_id
        script= mongodb-boostrap.sh
    }
    redis={
        sg_id= local.redis_sg_id
        script=redis-boostrap.sh
    }
    mysql={
        sg_id= local.mysql_sg_id
        script=mysql-boostrap.sh
    }
    rabbitmq={
        sg_id= local.rabbitmq_sg_id
        script=rabbitmq-boostrap.sh
    }
  }
}

locals {
  mongodb_sg_id= data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id= data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id= data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq_sg_id=data.aws_ssm_parameter.rabbitmq_sg_id.value
  ami=data.aws_ami.join_devops.id
  database_subnet_id=split(",",data.aws_ssm_parameter.database_subnets.value)[0]
}

locals {
  common_name="${var.Project}-${var.Environment}"
  common_tags={
    Project= var.Project
    Environment= var.Environment
    Terraform=true
  }
}
