build_name = "tumbleweed"

iso_urls = [
  "https://mirror.nl.leaseweb.net/opensuse/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Snapshot20251225-Media.iso",
  "https://opensuse.mirror.liteserver.nl/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Snapshot20251225-Media.iso",
]
iso_checksum = "sha256:54701839b932f6dc5c23a38d54a9febffdfa4d147558ffa4fc587b15a2834302"

http_content = {
  path = "/autoyast.xml"
  tpl  = "files/autoyast.xml.tpl"
}

boot_command = [
  "c<wait>",
  "linux /boot/x86_64/loader/linux splash=silent textmode=1 netsetup=dhcp autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoyast.xml<enter><wait>",
  "initrd /boot/x86_64/loader/initrd<enter><wait>",
  "boot<enter>",
]
