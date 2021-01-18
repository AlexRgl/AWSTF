variable "key_name" {
  default = "Alex"
}

variable "tags" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "GRSI"
    Name = "GRSI"
  }
}

variable "volume_tags" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "GRSI"
  }
}

variable "tags1" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "GRSI1"
    Name = "GRSI1"
  }
}

variable "volume_tags1" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "GRSI1"
  }
}

variable "sec_group_name" {
  default = "TF-GROUP"
}

variable "sec_group_description" {
  default = "TF-GROUP"
}

variable "SRV" {
  default = "./server.sh"
}

variable "CLI" {
  default = "./client.sh"
}

variable "volume_size" {
  default = 30
}


variable "ip_list" {
  description = "Allowed IPs"
  type = list(string)
  default = [
    "82.154.9.231/32",
  ]
}

variable "port_list" {
  description = "Allowed ports"
  type = list(number)
  default = [
    22,
    80,
    8080,
    8443,
  ]
}
