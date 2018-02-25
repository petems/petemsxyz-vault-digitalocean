# petemsxyz-vault-digitalocean

The example launches an Ubuntu 16.04, runs apt-get update and installs nginx. Also demonstrates how to create DNS records under Domains at DigitalOcean.

A Terraform repo that creates a Droplet that I'm going to later use for Vault.

This includes:

* Creating an SSH key in DigitalOcean
* Doing some basic provisioning on it (Right now just an apt-upgrade)
* Creating a new DigitalOcean Firewall rule just for inbound 22, outbound 8200

## Prerequisites

You need to export your DigitalOcean API Token as an environment variable

    export DIGITALOCEAN_TOKEN="Put Your Token Here"

## Run using

    terraform init
    terraform plan
    terraform apply
