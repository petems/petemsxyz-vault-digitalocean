provider "digitalocean" {
  version = "0.1.3"

  # export DIGITALOCEAN_TOKEN="Your API TOKEN"  #
}

resource "digitalocean_ssh_key" "petems_xyz_ssh_key" {
  name       = "Petems Vault SSH Key"
  public_key = "${file(var.petems_xyz_vault_ssh_pub)}"
}

resource "digitalocean_droplet" "petems_vault_server" {
  ssh_keys = ["${digitalocean_ssh_key.petems_xyz_ssh_key.id}"]
  image    = "${var.ubuntu}"
  region   = "${var.do_lon1}"
  size     = "1gb"
  name     = "vault.petems.xyz"

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.petems_xyz_vault_ssh_private)}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

resource "digitalocean_firewall" "vault" {
  name = "only-8200-and-22"

  droplet_ids = ["${digitalocean_droplet.petems_vault_server.id}"]

  # SSH inward only
  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  # Vault Outward
  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "8200"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}
