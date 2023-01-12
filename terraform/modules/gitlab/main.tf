terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}
provider "gitlab" {
  token = var.gitlab_token
#   base_url = "https://gitlab.com/api/v4/"
}

resource "gitlab_project_variable" "soobr" {
  for_each = var.gitlab_project_vars
  project   = var.gitlab_project_name
  key       = each.key
  value     = each.value
  protected = false
  masked = false
  variable_type = "env_var"
  environment_scope = "*"
}