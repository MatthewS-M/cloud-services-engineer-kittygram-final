output "vm_external_ip" {
  description = "External IP address of the Kittygram VM."
  value       = yandex_compute_instance.kittygram.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  description = "Internal IP address of the Kittygram VM."
  value       = yandex_compute_instance.kittygram.network_interface[0].ip_address
}

output "gateway_url" {
  description = "Public URL of the Kittygram gateway."
  value       = "http://${yandex_compute_instance.kittygram.network_interface[0].nat_ip_address}"
}

output "security_group_id" {
  description = "Security group ID attached to the VM."
  value       = yandex_vpc_security_group.kittygram.id
}

output "bucket_name" {
  description = "Application bucket name in Object Storage."
  value       = yandex_storage_bucket.kittygram.id
}
