##############################
## OCI Provider - Variables ##
##############################

# OCI authentication variables

variable "oci_tenancy" {
  type = string
  description = "OCI tenancy identifier"
}

variable "oci_user" {
  type = string
  description = "OCI user identifier"
}

variable "oci_fingerprint" {
  type = string
  description = "OCI fingerprint for the key pair"
}

variable "oci_key" {
  type = string
  description = "OCI key pair"
}

variable "oci_region" {
  type = string
  description = "OCI region"
}

variable "oci_root_compartment" {
  type = string
  description = "OCI root compartment"
}