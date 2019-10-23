 provider "github" {
 organization = "${var.github_organization}"
 token        = "${var.TOKEN}"  
  } 


resource "github_team" "Baluga" {
name        = "Baluga"
description = "Baluga team"
privacy     = "closed"
}



