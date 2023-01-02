module "api-dns" {
    source = "../modules/services"
    project_id = var.project_id
    service_name = "dns.googleapis.com"    
}
module "api-container" {
    source = "../modules/services"
    project_id = var.project_id
    service_name = "container.googleapis.com"    
}
