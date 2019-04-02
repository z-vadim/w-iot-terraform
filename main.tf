# # Configure the Terraform backend
# terraform {
#   backend "gcs" {
#     # Be sure to change this bucket name and region to match an GCS Bucket you have already created!
#     bucket  = "w-iot"
#     prefix  = "terraform/state"
#   }
# }

# Configure the GCP Provider
provider "google" {
  region      = "europe-west3"
  zone        = "europe-west3-c"
}


# This shows an example of how to use a Terraform module.
module "example_nodejs_app" {
  # The source field can be a path on your file system or a Git URL
  source = "./modules"

  # Pass parameters to the module
  name = "${var.app_name}"
  port = 8080
}



# # Get the latest Debian Image
# data "google_compute_image" "debian_image" {
#   family    = "debian-9"
#   project = "debian-cloud"
# }

# # Create an compute instance
# resource "google_compute_instance" "example" {
#   name         = "${var.ce_name}"
#   machine_type = "f1-micro"
#   zone         = "europe-west3-c"

#   tags = ["example", "http"]

#   boot_disk {
#     initialize_params {
#       image = "${data.google_compute_image.debian_image.self_link}"
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {
#       // Ephemeral IP
#     }
#   }

#   labels = {
#     ita_group = "w-iot"
#   }
# }