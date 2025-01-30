variable "common_name" {
  type = string
}

variable "dns_names" {
  type    = list(string)
  default = []
}

variable "ip_addresses" {
  type    = list(string)
  default = []
}

resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name = var.common_name
  }

  dns_names    = var.dns_names
  ip_addresses = var.ip_addresses
}

output "private_key" {
  value = nonsensitive(tls_private_key.server.private_key_pem)
}

output "csr" {
  value = tls_cert_request.server.cert_request_pem
}