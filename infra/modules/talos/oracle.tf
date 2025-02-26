resource "oci_core_subnet" "talos_subnet" {
  compartment_id = var.oci_compartment_id
  vcn_id         = var.oci_vcn_id

  display_name = "talos-subnet"
  cidr_block   = "10.72.10.0/24"

  dns_label = "talos"
}

resource "oci_core_instance" "talos_worker" {
  count = 0 # FIXME: currently unavailable

  compartment_id = var.oci_compartment_id
  availability_domain = var.oci_instance_availability_domain

  display_name = "talos-worker-01"
  state = "STOPPED" # TODO: turn on when everything is ready

  shape = "VM.Standard.A1.Flex"
  shape_config {
    ocpus = 2
    memory_in_gbs = 8
  }

  source_details {
    source_type = "image"
    # will be manually booted with talos image
    source_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaax65kresevp22fzwqj3yy553ktmoekrhjmgx3p3p2tvk4hsw3vxmq"

    boot_volume_size_in_gbs = 120
  }

  create_vnic_details {
    display_name = "talos-worker-01-vnic"
    subnet_id = oci_core_subnet.talos_subnet.id

    hostname_label = "talos-worker-01"
    assign_private_dns_record = true
    private_ip = "10.72.10.101"

    assign_public_ip = true
  }
}
