variable "instance_type" {
    default = "t3.micro"
    type = string
    validation {
      condition = contains(["t3.micro","t3.small","t3.medium"], var.instance_type)
      error_message = "Instance type should be either t3.small or t3.micro"

}
}

variable "Project" {
  
}

variable "Environment" {
  
}

variable "database_tags" {
    default = {}
}

variable "zone_id" {
    default = "Z07423591GD2G8GTI4KPQ"
  
}

variable "domain_name" {
    default = "daws-90.online"
  
}

variable "mysql_root_password" {
   type = string
}