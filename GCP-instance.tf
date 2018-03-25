variable "region" {
  default = "europe-west1-d" // We're going to need it in several places in this config
}
 
provider "google" {
  credentials = "${file("login-details.json")}"
  project     = "master-charmer-198216"
  region      = "${var.region}" // Call it from variable "region"
}
 
resource "google_compute_firewall" "allow-http" {  
    name = "allow-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["http"]
}

resource "google_compute_instance" "jupyter" {
  count        = 1
  name         = "jupyter-gpu" 
  machine_type = "n1-standard-4" 
  zone         = "${var.region}" // Call it from variable "region"

  tags = ["http"]
 
 boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size = 50
    }
  }
 
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  guest_accelerator{
    type = "nvidia-tesla-k80" // Type of GPU attahced
    count = 1 // Num of GPU attached
  }

  scheduling{
    on_host_maintenance = "TERMINATE" // Need to terminate GPU on maintenance
  }

  metadata_startup_script = "${file("start-up-script.sh")}" // Add the startup script locally

}