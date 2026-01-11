terraform {
  required_providers {
    mycloud = {
      source = "hashicorp/mycloud"
    }
  }
}

provider "mycloud" {
  endpoint = "http://localhost:3000"
}

resource "mycloud_project" "demo" {
  name        = "Test Project from Framework"
  description = "Created by my own provider!"
}