variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "credentials" {
  type        = list
  default     = ["/home/dawid/.aws/credentials"]
  sensitive   = true
}

variable "name" {
  type    = string
  default = "dawid-terra"
}

variable "num" {
  type = bool
  description = "Type true if You want to deploy two instances"
  default = false
}
