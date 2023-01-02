terraform {
  required_providers {
    google = {
      # version = "~> 3.58.0"
    }

    kubernetes = {
      # version = "~> 2.0.2"
    }

    local = {
      # version = "~> 2.1.0"
    }

    random = {
      # version = "~> 3.1.0"
    }
  }
  required_version = ">= 1.2.3" #terraform version
}