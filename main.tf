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