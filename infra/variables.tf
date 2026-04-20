variable "service_account_key_file" {
  description = "Path to the Yandex Cloud service account authorized key JSON file."
  type        = string
  default     = ""
}

variable "cloud_id" {
  description = "Yandex Cloud cloud ID."
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID."
  type        = string
}

variable "zone" {
  description = "Availability zone for the infrastructure."
  type        = string
  default     = "ru-central1-a"
}

variable "vm_name" {
  description = "Virtual machine name."
  type        = string
  default     = "kittygram-vm"
}

variable "vm_user" {
  description = "Linux user created for deployments."
  type        = string
  default     = "deployer"
}

variable "ssh_public_key" {
  description = "SSH public key for the deployment user."
  type        = string
  sensitive   = true
}

variable "image_family" {
  description = "Base image family for the VM."
  type        = string
  default     = "ubuntu-2404-lts"
}

variable "platform_id" {
  description = "Compute platform ID."
  type        = string
  default     = "standard-v3"
}

variable "vm_cores" {
  description = "Amount of CPU cores for the VM."
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Amount of RAM in GB for the VM."
  type        = number
  default     = 4
}

variable "core_fraction" {
  description = "Guaranteed CPU fraction for the VM."
  type        = number
  default     = 100
}

variable "boot_disk_size" {
  description = "Boot disk size in GB."
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "Boot disk type."
  type        = string
  default     = "network-hdd"
}

variable "preemptible" {
  description = "Whether to create a preemptible VM."
  type        = bool
  default     = false
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "gateway_port" {
  description = "Public port for the gateway service."
  type        = number
  default     = 80
}

variable "bucket_prefix" {
  description = "Prefix for the application Object Storage bucket."
  type        = string
  default     = "kittygram-matthews2003-"
}

variable "storage_access_key" {
  description = "Static access key for Object Storage operations."
  type        = string
  sensitive   = true
}

variable "storage_secret_key" {
  description = "Static secret key for Object Storage operations."
  type        = string
  sensitive   = true
}
