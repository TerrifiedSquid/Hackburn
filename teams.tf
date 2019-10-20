 provider "github" {
 organization = "${var.github_organization}"
 token        = "${var.TOKEN}"  
  } 


 resource "github_membership" "dogi" {
 username = "dogi"
 role = "member" 
 }



