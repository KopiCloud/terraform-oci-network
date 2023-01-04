#################
## Compartment ##
#################

# Create the OCI Compartment
resource "oci_identity_compartment" "compartment" {
  compartment_id = var.oci_root_compartment
  description    = "Compartment for ${var.app_name} resources"
  name           = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}"
  enable_delete  = true

  freeform_tags = {
    "Application" = var.app_name
    "Environment" = var.environment
  }
}
