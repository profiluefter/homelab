output "compartment_ocid" {
  description = "OCID of the compartment for all homelab resources"
  value       = oci_identity_compartment.homelab_compartment.id
}

output "vcn_ocid" {
  description = "OCID of the VCN used for all homelab resources"
  value       = oci_core_vcn.homelab-vcn.id
}

output "ads" {
  description = "Availability domains in the homelab compartment"
  value       = data.oci_identity_availability_domains.ads.availability_domains
}
