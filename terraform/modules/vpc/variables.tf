variable "project_name" {
  
}
variable "region" {
  
}
variable "subnet_regions" {
  type = set(object({
    region = string
    cidr = string
  }))
}
variable "auto_create_subnetworks" {
  default = false
}
variable "delete_default_routes_on_create" {
  default = false
}
variable "routing_mode" {
  default = "REGIONAL"
}
# variable "private_subnet_cidr" {
  
# }
# variable "public_subnet_cidr" {
  
# }