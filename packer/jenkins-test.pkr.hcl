packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "vagrant" "jenkins-jammy64" {
  communicator = "ssh"
  source_path = "ubuntu/jammy64"
  provider = "virtualbox"
}

build {
  name = "jenkins-jammy64-build"
  sources = ["source.vagrant.jenkins-jammy64"]

  provisioner "shell" {
    scripts = [
      "scripts/wait-for-cloud-init.sh",
      "scripts/install-docker.sh",
      "scripts/install-jenkins.sh",
      "scripts/install-gh.sh",
      "scripts/install-extras.sh"
    ]
  }
}

