locals {
  name_prefix = "kittygram"

  common_labels = {
    project    = "kittygram"
    managed_by = "terraform"
    owner      = "MatthewS-M"
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_vpc_network" "kittygram" {
  name = "${local.name_prefix}-network"

  labels = local.common_labels
}

resource "yandex_vpc_subnet" "kittygram" {
  name           = "${local.name_prefix}-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.kittygram.id
  v4_cidr_blocks = [var.subnet_cidr]

  labels = local.common_labels
}

resource "yandex_vpc_security_group" "kittygram" {
  name        = "${local.name_prefix}-sg"
  description = "Ingress only for SSH and HTTP gateway, all egress allowed."
  network_id  = yandex_vpc_network.kittygram.id

  ingress {
    protocol       = "TCP"
    description    = "SSH access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Kittygram gateway"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = var.gateway_port
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  labels = local.common_labels
}

resource "yandex_storage_bucket" "kittygram" {
  bucket_prefix = var.bucket_prefix
  force_destroy = true

  tags = local.common_labels
}

resource "yandex_compute_instance" "kittygram" {
  name        = var.vm_name
  hostname    = var.vm_name
  platform_id = var.platform_id
  zone        = var.zone

  allow_stopping_for_update = true

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.boot_disk_size
      type     = var.boot_disk_type
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kittygram.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.vm_user}:${var.ssh_public_key}"
    user-data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
      vm_user        = var.vm_user
      ssh_public_key = var.ssh_public_key
      app_dir        = "/home/${var.vm_user}/kittygram"
    })
  }

  labels = local.common_labels
}
