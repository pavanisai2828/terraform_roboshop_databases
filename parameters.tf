resource "aws_ssm_parameter" "storing_roboshop_dev_db_private_ips" {
    for_each = aws_instance.creating_roboshop_db_instances
    name="/${var.Project}/${var.Environment}/${each.key}/private_ip"
    type = "String"
    value = each.value.private_ip
    
}

resource "aws_ssm_parameter" "storing_roboshop_dev_db_dns" {
    for_each = aws_route53_record.creating_roboshop_db_route53_records
    name="/${var.Project}/${var.Environment}/${each.key}/dns"
    type = "String"
    value = each.value.fqdn
    
}

resource "aws_ssm_parameter" "mysql_password" {
    name="/${var.Project}/${var.Environment}/mysql_root_password"
    type = "SecureString"
    value = var.mysql_root_password
    
}