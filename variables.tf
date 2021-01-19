variable "key_name" {
  default = "Alex"
}

variable "tags" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "Server"
    Name = "Server"
  }
}

variable "volume_tags" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "Server"
  }
}

variable "tags1" {
  type = map(string)
  default = {
    Ano = "2021"
    Curso = "CLIENTE"
    Name = "CLIENTE"
  }
}

variable "volume_tags1" {
  type = map(string)
  default = {
    Ano = "CLIENTE"
    Curso = "CLIENTE"
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
    3389,
  ]
}
