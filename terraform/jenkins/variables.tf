variable "public_key_path" {
  description = "Path to public key file for Jenkins master"
  default = "~/.ssh/id_rsa.pub"
}

variable "service_account_key_file" {
  description = "Yandex Cloud security OAuth token for Jenkins master"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where Jenkins master will be created"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where Jenkins master will be created"
}

variable "master_zone" {
  description = "Yandex Cloud default Zone for Jenkins master"
  default = "ru-central1-b"
}

variable "master_cores" {
  description = "Cores per one instance for Jenkins master"
  default     = "2"
}

variable "master_memory" {
  description = "Memory in GB per one instance for Jenkins master"
  default     = "2"
}

variable "master_disk_type" {
  description = "Disk type for Jenkins master"
  default     = "network-nvme"
}

variable "master_disk_size" {
  description = "Disk size for Jenkins master in gigabytes"
  default = "15"
}

variable "master_image_family" {
  description = "Image family for jenkins master"
  default = "jenkins"
}

variable "master_vpc_subnet_name" {
  description = "VPC subnet name for jenkins master"
  default = "default-ru-central1-b"
}

variable "username" {
  description = "Username for administrative user"
}

variable "password" {
  description = "Password for administrative user"
}

variable "local_user" {
  description = "Local user to create on instance"
  default = "ubuntu"
}