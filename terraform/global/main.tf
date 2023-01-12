module "gitlab_myproject" {
  source = "../modules/gitlab"
  gitlab_token = var.gitlab_token
  gitlab_project_name = var.gitlab_project_id #add project id instead of name
  gitlab_project_vars = var.myproject_vars
}