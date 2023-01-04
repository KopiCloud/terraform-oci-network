####################
## Security Lists ##
####################

# Local Variables for Security Lists
locals {
  tcp_protocol     = "6"
  udp_protocol     = "17"
  icmp_protocol    = "1"
  icmp_v6_protocol = "58"
  all_protocols    = "all"
  anywhere         = "0.0.0.0/0"
}

# Create a Security List for the Public Subnet
resource "oci_core_security_list" "public_security_list"{
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-public-security-list"

  # RDP TCP Port 3389 from VNC
  ingress_security_rules {
    description = "RDP TCP Port 3389"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = element(var.vnc_cidr_block, 0)
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 3389
        max = 3389
    }
  }

  # SSH TCP Port 22 from VNC
  ingress_security_rules {
    description = "SSH TCP Port 22"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = element(var.vnc_cidr_block, 0)
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 22
        max = 22
    }
  }

  # HTTP TCP Port 80 from anywhere
  ingress_security_rules {
    description = "HTTP TCP Port 80"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = local.anywhere
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 80
        max = 80
    }
  }

  # HTTPS TCP Port 443 from anywhere
  ingress_security_rules {
    description = "HTTPS TCP Port 443"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = local.anywhere
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 443
        max = 443
    }
  }
}

# Create a Security List for the Private Subnet
resource "oci_core_security_list" "private_security_list"{
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-private-security-list"

  # RDP TCP Port 3389 from VNC
  ingress_security_rules {
    description = "RDP TCP Port 3389"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = element(var.vnc_cidr_block, 0)
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 3389
        max = 3389
    }
  }

  # SSH TCP Port 22 from VNC
  ingress_security_rules {
    description = "SSH TCP Port 22"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = element(var.vnc_cidr_block, 0)
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 22
        max = 22
    }
  }

  # HTTP TCP Port 80 from VNC
  ingress_security_rules {
    description = "HTTP TCP Port 80"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = element(var.vnc_cidr_block, 0)
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 80
        max = 80
    }
  }

  # HTTPS TCP Port 443 from VNC
  ingress_security_rules {
    description = "HTTPS TCP Port 443"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = element(var.vnc_cidr_block, 0)
    source_type = "CIDR_BLOCK"

    tcp_options {
        min = 443
        max = 443
    }
  }
}