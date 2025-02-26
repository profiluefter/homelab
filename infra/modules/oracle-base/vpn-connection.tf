resource "oci_core_drg" "homelab-drg" {
  compartment_id = oci_identity_compartment.homelab_compartment.id

  display_name = "homelab-drg"
}

resource "oci_core_drg_attachment" "homelab-drg-attachment" {
  drg_id       = oci_core_drg.homelab-drg.id
  display_name = "homelab-drg-attachment"

  network_details {
    id = oci_core_vcn.homelab-vcn.id
    type = "VCN"
  }

  # drg_route_table_id = oci_core_drg_route_table.homelab-drg-route-table.id
}

// TODO: route table, security list

# resource "oci_core_drg_route_table" "homelab-drg-route-table" {
#   drg_id = oci_core_drg.homelab-drg.id
# }
#
# resource "oci_core_drg_route_table_route_rule" "homelab-drg-main-network-rule" {
#   drg_route_table_id = oci_core_drg_route_table.homelab-drg-route-table.id
#
#   destination_type = "CIDR_BLOCK"
#   destination      = "10.0.0.0/24"
#
#   next_hop_drg_attachment_id = oci_core_drg_attachment.homelab-drg-attachment.id
# }

resource "oci_core_cpe" "archer-c7-cpe" {
  compartment_id = oci_identity_compartment.homelab_compartment.id

  display_name = "archer-c7-cpe"
  ip_address   = "10.0.0.1" # internal IP, external is dynamic

  # id of "Libreswan 3.18 or later" aquired via oci_core_cpe_device_shapes data source
  cpe_device_shape_id = "a488553d-c65e-435e-be93-2584f2a07ab7"
}
