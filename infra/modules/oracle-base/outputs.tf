output "compartment_ocid" {
  description = "OCID of the compartment for all homelab resources"
  value       = oci_identity_compartment.homelab_compartment.id
}

output "vcn_ocid" {
  description = "OCID of the VCN used for all homelab resources"
  value       = module.vcn.vcn_id
}
