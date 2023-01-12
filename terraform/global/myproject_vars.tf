variable "myproject_vars" {
  default = {
      "environment" = "${terraform.workspace}" #global
      "owner" = "rishi"
  }
}