module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.6.0"

  compartment_id = oci_identity_compartment.homelab_compartment.id

  vcn_name = "homelab-vcn"
  vcn_cidrs = [ "10.72.0.0/16" ]
  vcn_dns_label = "homelab"
}
