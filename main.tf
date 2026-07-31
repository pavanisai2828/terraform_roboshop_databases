resource "aws_instance" "creating_roboshop_db_instances" {
    for_each=local.databases
    ami= local.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [each.value.sg_id]
    subnet_id = local.database_subnet_id
    tags=merge(
        {
            Name="${local.common_name}-${each.key}"
        },
        local.common_tags
    )


}

resource "terraform_data" "boostrap-databases" {
    for_each = aws_instance.creating_roboshop_db_instances
    triggers_replace = [
        each.value.id
    ]

    connection {
        type ="ssh"
        user = "ec2-user"
        password="DevOps321"
        host= each.value.private_ip
      
    }


    provisioner "file" {
        source="${path.module}/scripts/${local.databases[each.key].script}"
        destination = "/tmp/bootstrap.sh"
      
    }

    provisioner "remote-exec" {
        inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh redis ${var.Environment}"
         ]
    }

}
  

