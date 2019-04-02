# Get Image
data "google_compute_image" "debian_image" {
  family    = "debian-9"
  project = "debian-cloud"
}

# Create an Compute instance
resource "google_compute_instance" "example_nodejs_app" {
  name         = "${var.name}"
  machine_type = "f1-micro"

  tags = ["http"]

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.debian_image.self_link}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.public.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  # Doesn't force to recreate instance
  metadata {
    startup-script = "${data.template_file.user_data.rendered}"
  }

  # Forces to recreate the instance if changed
  # metadata_startup_script = "${data.template_file.user_data.rendered}"
}
# A User Data script that will run when the Compute instance boots up and install Docker
data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.sh")}"

  vars {
    port = "${var.port}"
  }
}

# A Firewall Rule that controls what network traffic can go in and out of the Compute instance
resource "google_compute_firewall" "example_nodejs_app" {
  name    = "${var.name}"
  network = "${google_compute_network.example_net.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }

  target_tags = ["http"]
}

resource "google_compute_firewall" "allow-outbound" {
  name    = "${var.name}-allow-outbound"
  network = "${google_compute_network.example_net.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}
