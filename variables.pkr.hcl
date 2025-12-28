variable "build_name" {
  type = string
}

variable "iso_urls" {
  type = list(string)
}

variable "iso_checksum" {
  type = string
}

variable "http_content" {
  type = object({
    path = string
    tpl  = string
  })
}

variable "boot_command" {
  type = list(string)
}

variable "authorized_key" {
  type    = string
  default = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIC6G78vGIgPs/FXEXRBgsq0EyzABVZ5fU1Rxr8MjzhiyAAAABHNzaDo= user@sz.internal.three-sigma.org"
}

variable "encrypted_root_password" {
  type    = string
  default = "$6$Xsle4/jQcAS$2GjVwBR/XvzOSVOPyrlqt6msOkOTMM6GQ5tOPYcf6su6AIzjH17IWxq20kqCR83Oe.t1WXDe4GcUirymf.FsS1"
}

variable "headless" {
  type    = bool
  default = true
}

variable "iface_bus" {
  type    = number
  default = 1
}

variable "iface_address" {
  type    = number
  default = 0
}
