#########################
## OCI Provider - Main ##
#########################

# Define the Terraform provider
terraform {
  required_version = ">= 1.3"

  required_providers {
    oci = {
      source  = "oracle/oci"
        version = ">= 4.0.0"
      }
    }
}

# Configure the OCI provider
provider "oci" {
  tenancy_ocid     = var.oci_tenancy
  user_ocid        = var.oci_user
  fingerprint      = var.oci_fingerprint
  private_key_path = var.oci_key
  region           = var.oci_region
}
