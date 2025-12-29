#_preseed_V1
d-i debian-installer/locale string en_GB.UTF-8

d-i keyboard-configuration/xkb-keymap select gb

d-i netcfg/choose_interface select ${iface}

d-i passwd/root-password-crypted password ${encrypted_root_password}
d-i passwd/user-fullname string user
d-i passwd/username string user
d-i passwd/user-password-crypted password !

d-i clock/setup/utc boolean true
d-i time/zone string Etc/UTC
d-i clock-setup/ntp boolean true

d-i partman-auto/method string regular
d-i partman-auto/choose_recipe select atomic
d-i partman/choose_partition select finish
d-i partman/confirm_nooverwrite boolean true
d-i partman-partitioning/choose_label select gpt
d-i partman-partitioning/default_label string gpt

tasksel tasksel/first multiselect standard, ssh-server
d-i pkgsel/upgrade select safe-upgrade

d-i grub-installer/only_debian boolean true

d-i finish-install/reboot_in_progress note
d-i debian-installer/exit/poweroff boolean true

d-i preseed/late_command string \
	in-target mkdir -p /home/user/.ssh; \
	in-target /bin/sh -c "echo '${authorized_key}' >> /home/user/.ssh/authorized_keys"; \
	in-target chown -R user:user /home/user/.ssh; \
	in-target chmod 0700 /home/user/.ssh; \
	in-target chmod 0644 /home/user/.ssh/authorized_keys; \
	in-target /bin/sh -c 'echo GRUB_CMDLINE_LINUX=\"console=ttyS0,115200n8r\" > /etc/default/grub.d/cmdline.cfg'; \
	in-target /bin/sh -c 'echo GRUB_TERMINAL=console > /etc/default/grub.d/terminal.cfg'; \
	in-target update-grub; \
	in-target /bin/sh -c "echo 'ChallengeResponseAuthentication no' > /etc/ssh/sshd_config.d/50custom.conf"; \
	in-target /bin/sh -c "echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/50custom.conf"; \
	in-target /bin/sh -c "echo 'PermitRootLogin no' >> /etc/ssh/sshd_config.d/50custom.conf"; \
	in-target /bin/sh -c "echo 'PrintMotd no' >> /etc/ssh/sshd_config.d/50custom.conf"; \
	in-target /bin/sh -c 'echo Y | apt modernize-sources'; \
	in-target rm -f /etc/apt/sources.list.bak /etc/apt/sources.list.d/moved-from-main.sources;
