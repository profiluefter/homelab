terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.27.0"
    }
  }
}

resource "oci_identity_compartment" "homelab_compartment" {
  description = "Compartment for homelab resources"
  name        = "homelab"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.homelab_compartment.id
}
