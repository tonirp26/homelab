variable "virtual_environment_api_token" {
    type = string
}

variable "virtual_environment_endpoint" {
    type = string
}

variable "gateway" {
  type = string
  default = "192.168.0.1"
}

variable "uptime_kuma_id" {
  type = number
}

variable "uptime_kuma_hostname" {
  type = string
}

variable "uptime_kuma_ip" {
  type = string
}

variable "homarr_hostname" {
  type = string
}

variable "homarr_id" {
  type = number
}

variable "homarr_ip" {
  type = string
}

variable "sonarr_hostname" {
  type = string
}

variable "sonarr_id" {
  type = number
}

variable "sonarr_ip" {
  type = string
}