build_name = "debian"

iso_urls = [
  "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.2.0-amd64-netinst.iso",
]
iso_checksum = "sha256:677c4d57aa034dc192b5191870141057574c1b05df2b9569c0ee08aa4e32125d"

http_content = {
  path = "/preseed.cfg"
  tpl  = "templates/debian.pkrtpl.hcl"
}
boot_command = [
  "c<wait>",
  "linux /install.amd/vmlinuz auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter><wait>",
  "initrd /install.amd/initrd.gz<enter><wait>",
  "boot<enter>",
]
