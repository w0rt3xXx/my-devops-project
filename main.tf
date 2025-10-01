# Указываем, с каким провайдером мы будем работать (digitalocean)
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Переменная для нашего токена. Terraform будет искать его в системных переменных.
variable "do_token" {}

# Настраиваем подключение к DigitalOcean
provider "digitalocean" {
  token = var.do_token
}

# Описываем наш будущий сервер (здесь он называется "droplet")
resource "digitalocean_droplet" "web" {
  image    = "docker-20-04" # Готовый образ Ubuntu с предустановленным Docker
  name     = "my-devops-server"
  region   = "fra1" # Регион Франкфурт, можешь выбрать другой (например, ams3, nyc3)
  size     = "s-1vcpu-1gb" # Самый простой и дешевый тип сервера

  # SSH-ключ для доступа к серверу. Мы создадим его на следующем шаге.
  # Пока эту строку можно закомментировать, добавив '#' в начале.
  # ssh_keys = [digitalocean_ssh_key.default.id]
}