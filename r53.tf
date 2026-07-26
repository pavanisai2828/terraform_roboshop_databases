resource "aws_route53_record" "creating_roboshop_db_route53_records" {
  for_each = aws_instance.creating_roboshop_db_instances
  zone_id = var.zone_id
  name= "${each.key}-${var.Environment}.${var.domain_name}"
  type = "A"
  ttl= 1
  records =[each.value.private_ip]

}
