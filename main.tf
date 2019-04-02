provider "google" {
  region      = "europe-west3"
  zone        = "europe-west3-c"
}

# This shows an example of how to use a Terraform module.
module "pubsub_app" {
  # The source field can be a path on your file system or a Git URL
  source = "./local-modules/pubsub"

  # Pass parameters to the module
  # name = "${var.app_name}"
  # port = 8080
}

module "memorystore" {
  source = "./local-modules/cash"
  
}
