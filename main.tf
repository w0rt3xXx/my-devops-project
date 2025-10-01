terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

# Terraform теперь сам управляет SSH-ключом
resource "digitalocean_ssh_key" "default" {
  name       = "DevOps Project Key"
  # Он сам прочитает твой новый публичный ключ из файла!
  public_key = file("~/.ssh/id_rsa.pub")
}

# Сервер теперь использует ключ, созданный выше
resource "digitalocean_droplet" "web" {
  image    = "docker-20-04"
  name     = "my-devops-server"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  # Указываем ID ключа, которым будет управлять Terraform
  ssh_keys = [digitalocean_ssh_key.default.id]
}

# Чтобы легко узнать IP-адрес нового сервера
output "droplet_ip_address" {
  value = digitalocean_droplet.web.ipv4_address
}