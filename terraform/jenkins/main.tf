provider "yandex" {
  service_account_key_file     = "${var.service_account_key_file}"
  cloud_id  = "${var.cloud_id}"
  folder_id = "${var.folder_id}"
}

data "yandex_compute_image" "jenkins_master_image" {
  family = "${var.master_image_family}"
}

data "yandex_vpc_subnet" "jenkins_subnet" {
  name = "${var.master_vpc_subnet_name}"
}

data "template_file" "basic-security" {
  template = "${file("${path.module}/bootstrap/init.groovy.d/basic-security.groovy")}"
  vars = {
    username = "${var.username}"
    password = "${var.password}"
  }
}

resource "yandex_compute_instance" "jenkins_master" {
  name        = "jenkins-tutorial"
  hostname    = "jenkins-tutorial"
  description = "Jenkins Master node"
  zone = "${var.master_zone}"

  resources {
    cores  = "${var.master_cores}"
    memory = "${var.master_memory}"
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.jenkins_master_image.id}"
      type = "${var.master_disk_type}"
      size = "${var.master_disk_size}"
    }
  }


  network_interface {
    subnet_id = "${data.yandex_vpc_subnet.jenkins_subnet.id}"
    nat       = true
  }

  metadata {
    ssh-keys  = "${var.local_user}:${file("${var.public_key_path}")}"
  }

  connection {
    user = "${var.local_user}"
  }

  # provisioner "remote-exec" {
  #   script = "${path.module}/bootstrap/wait-for-marketplace.sh"
  # }

  provisioner "file" {
    content = "${data.template_file.basic-security.rendered}"
    destination = "/tmp/basic-security.groovy"
  }
  # provisioner "remote-exec" {
  #   inline = [
  #     "puppet apply",
  #     "consul join ${aws_instance.web.private_ip}",
  #   ]
  # }
}

locals {
  master_external_ip = "${yandex_compute_instance.jenkins_master.network_interface.0.nat_ip_address}"
  master_internal_ip = "${yandex_compute_instance.jenkins_master.network_interface.0.ip_address}"
}
