terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.7.0"
    }
  }
}

resource "oci_identity_compartment" "homelab_compartment" {
  description = "Compartment for homelab resources"
  name        = "homelab"
}
