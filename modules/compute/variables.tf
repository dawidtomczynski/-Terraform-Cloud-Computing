variable "vpc_id" {
  type    = string
}

variable "subnet_id_1" {
  type    = string
}

variable "subnet_id_2" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "av_zone_1" {
  type    = string
  default = "eu-central-1a"
}

variable "av_zone_2" {
  type    = string
  default = "eu-central-1b"
}

variable "ami" {
  type    = string
  default = "ami-0832d9f6aec53a2a0"
}

variable "name" {
  type    = string
  default = "dawid-terra"
}

variable "bootcamp" {
  type    = string
  default = "poland1"
}

variable "created_by" {
  type    = string
  default = "dawid"
}

variable "entrypoint" {
  type    = string
  default = <<-EOT
  #!/bin/bash -xe

  sudo apt-get update
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo rm get-docker.sh
  sudo docker pull adongy/hostname-docker
  sudo docker run -d --name hostname -p 80:3000 adongy/hostname-docker
  EOT
}

variable "num" {
  type = bool
  description = "Type true if You want to deploy two instances"
  default = false
}
