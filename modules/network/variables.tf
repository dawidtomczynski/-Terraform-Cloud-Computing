variable "av_zone_1" {
  type    = string
  default = "eu-central-1a"
}

variable "av_zone_2" {
  type    = string
  default = "eu-central-1b"
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

variable "num" {
  type = bool
  description = "Type true if You want to deploy two instances"
  default = false
}
