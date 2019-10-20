 provider "github" {
 organization = "${var.github_organization}"
 token        = "${var.TOKEN}"  
  } 

 resource "github_membership" "ArranTest" {
 username = "ArranTest"
 role = "member" 
 }

 resource "github_membership" "dogi" {
 username = "dogi"
 role = "member" 
 }



resource "github_team" "some_team" {
name        = "some-team"
description = "Some cool team"
privacy     = "closed"
}

