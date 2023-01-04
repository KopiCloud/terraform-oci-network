#########################
## Network - Variables ##
#########################

# VCN Subnet CIDR
variable "vcn_cidr_block" {
  type        = list(string)
  description = "Virtual Cloud Network CIDR Block"
}

# Private Subnet CIDR
variable "private_subnet_cidr_block" {
  type        = string
  description = "Private Subnet CIDR Block"
}

# Public Subnet CIDR
variable "public_subnet_cidr_block" {
  type        = string
  description = "Public Subnet CIDR Block"
}

# Enable ipv6
variable "enable_ipv6" {
  type        = bool
  description = "Enable ipV6"
  default     = false
}

# DNS Domain Name
variable "dns_domain_name" {
  type        = string
  description = "DNS Domain Name"
}

