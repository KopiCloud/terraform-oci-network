####################
## Network - Main ##
####################

# Create the OCI VCN 
resource "oci_core_vcn" "vcn" {
  depends_on = [oci_identity_compartment.compartment]

  cidr_blocks    = var.vnc_cidr_block
  compartment_id = oci_identity_compartment.compartment.id
  is_ipv6enabled = var.enable_ipv6
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-vcn"

  freeform_tags = {
    "Application" = var.app_name
    "Environment" = var.environment
  }

  lifecycle {
    ignore_changes = [defined_tags, dns_label, freeform_tags]
  }
}

# Create the DHCP Options
resource "oci_core_dhcp_options" "dhcp" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-dhcp-options"

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = [var.dns_domain_name]
  }
}

# Create the Internet Gateway
resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-igw"

  freeform_tags = {
    "Application" = var.app_name
    "Environment" = var.environment
  }
}

# Create a Route Table for Internet Gateway
resource "oci_core_route_table" "igw_route_table" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-igw-route-table"

  route_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
} 

# Create a Public Subnet
resource "oci_core_subnet" "public_subnet" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.public_subnet_cidr_block
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-public-subnet"

  route_table_id    = oci_core_route_table.igw_route_table.id
  dhcp_options_id   = oci_core_dhcp_options.dhcp.id
  security_list_ids = [oci_core_security_list.public_security_list.id]

  freeform_tags = {
    "Application" = var.app_name
    "Environment" = var.environment
  }

  lifecycle {
    ignore_changes = [defined_tags, dns_label, freeform_tags]
  }
}

# Create a NAT Gateway
resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-nat-gateway"
}

# Create a Route Table for the NAT Gateway
resource "oci_core_route_table" "nat_route_table" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-nat-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

# Create a Private Subnet
resource "oci_core_subnet" "private_subnet" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.private_subnet_cidr_block
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-private-subnet"

  prohibit_public_ip_on_vnic = true

  route_table_id    = oci_core_route_table.igw_route_table.id
  dhcp_options_id   = oci_core_dhcp_options.dhcp.id
  security_list_ids = [oci_core_security_list.private_security_list.id]

  freeform_tags = {
    "Application" = var.app_name
    "Environment" = var.environment
  }

  lifecycle {
    ignore_changes = [defined_tags, dns_label, freeform_tags]
  }
}
