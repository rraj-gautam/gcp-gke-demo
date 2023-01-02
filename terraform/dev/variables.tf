variable "org_id" {
  
}
variable "project_id" {
  
}
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

variable "subnet_name" {
}
variable "cluster_name" {
  
}