terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "8.9.0"
    }
  }
}

resource "oci_identity_compartment" "homelab_compartment" {
  description = "Compartment for homelab resources"
  name        = "homelab"
}
