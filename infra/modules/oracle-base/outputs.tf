output "compartment_ocid" {
  description = "OCID of the compartment for all homelab resources"
  value       = oci_identity_compartment.homelab_compartment.compartment_id
}
