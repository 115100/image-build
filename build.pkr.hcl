source "qemu" "build" {
  accelerator  = "kvm"
  memory       = "2048"
  machine_type = "q35"
  headless     = var.headless
  communicator = "none"
  disk_size    = "20480M"
  qemuargs = [
    ["-device", "pcie-root-port,id=pci.${var.iface_bus},addr=2"],
    ["-device", "virtio-net,netdev=user.0,bus=pci.${var.iface_bus},addr=${var.iface_address}"],
  ]
  shutdown_timeout = "15m"
  output_directory = "output-${var.build_name}"

  efi_boot          = true
  efi_firmware_code = "/usr/share/edk2/OvmfX64/OVMF_CODE.secboot.fd"
  efi_firmware_vars = "/usr/share/edk2/OvmfX64/OVMF_VARS.secboot.fd"
  efi_drop_efivars  = true
}

build {
  name = var.build_name

  source "source.qemu.build" {
    vm_name      = "${var.build_name}.qcow2"
    iso_urls     = var.iso_urls
    iso_checksum = var.iso_checksum
    http_content = {
      "${var.http_content.path}" = templatefile(
        "${path.root}/${var.http_content.tpl}",
        {
          authorized_key          = var.authorized_key,
          encrypted_root_password = var.encrypted_root_password,
          iface                   = "enp${var.iface_bus}s${var.iface_address}",
        },
      )
    }
    boot_command = var.boot_command
  }
}
