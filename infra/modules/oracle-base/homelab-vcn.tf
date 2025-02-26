resource "oci_core_vcn" "homelab-vcn" {
  compartment_id = oci_identity_compartment.homelab_compartment.id

  display_name = "homelab-vcn"
  cidr_block   = "10.72.0.0/16"
  dns_label    = "homelab"
}

moved {
  from = module.vcn.oci_core_vcn.vcn
  to   = oci_core_vcn.homelab-vcn
}
