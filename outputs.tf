output "Petems Vault Droplet Public ip" {
  value = "${digitalocean_droplet.petems_vault_server.ipv4_address}"
}

output "Name of Droplet" {
  value = "${digitalocean_droplet.petems_vault_server.name}"
}

