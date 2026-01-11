variables {
  subnet_cidr_block_newbits = 4
}

mock_provider "aws" {
  mock_data "aws_vpc" {
    defaults = {
      cidr_block = "172.31.0.0/16"
      id         = "vpc-12345678"
    }
  }

  mock_data "aws_subnet" {
    defaults = {
      id = "subnet-12345"
    }
  }
}

run "validate_plan" {
  command = plan

  assert {
    condition     = mycloud_project.demo.name == "Test Project from Framework"
    error_message = "Project name does not match the expected value"
  }
}

run "create_and_check_status" {
  command = apply

  assert {
    condition     = mycloud_project.demo.status == "active"
    error_message = "API returned an incorrect status after creation"
  }

  assert {
    condition     = can(regex("^[0-9a-f]{8}-", mycloud_project.demo.id))
    error_message = "Project ID must be a valid UUID"
  }
}
