<?xml version="1.0"?>
<!DOCTYPE profile>
<profile xmlns="http://www.suse.com/1.0/yast2ns"
 xmlns:config="http://www.suse.com/1.0/configns">
<general>
	<mode>
		<confirm config:type="boolean">false</confirm>
		<halt config:type="boolean">true</halt>
		<second_stage config:type="boolean">false</second_stage>
	</mode>
</general>
<bootloader>
	<global>
		<secure_boot>true</secure_boot>
		<append>console=ttyS0,115200n8r</append>
		<serial>serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1</serial>
		<terminal>serial</terminal>
	</global>
</bootloader>
<partitioning config:type="list">
	<drive>
		<initialize config:type="boolean">true</initialize>
		<use>all</use>
	</drive>
</partitioning>
<language>
	<language>en_GB</language>
</language>
<timezone>
	<hwclock>UTC</hwclock>
	<timezone>UTC</timezone>
</timezone>
<keyboard>
	<keymap>gb</keymap>
</keyboard>
<software>
	<do_online_update config:type="boolean">true</do_online_update>
	<patterns config:type="list">
		<pattern>console</pattern>
		<pattern>enhanced_base</pattern>
		<pattern>x86_64_v3</pattern>
	</patterns>
	<packages config:type="list">
		<package>transactional-update</package>
	</packages>
</software>
<add-on>
	<add_on_products config:type="list">
		<listentry>
			<media_url><![CDATA[http://download.opensuse.org/tumbleweed/repo/non-oss/]]></media_url>
			<product>openSUSE-Addon-NonOss</product>
			<alias>download.opensuse.org-non-oss</alias>
			<name>Main Repository (NON-OSS)</name>
		</listentry>
		<listentry>
			<media_url><![CDATA[http://download.opensuse.org/tumbleweed/repo/oss/]]></media_url>
			<product>openSUSE</product>
			<alias>download.opensuse.org-oss</alias>
			<name>Main Repository (OSS)</name>
		</listentry>
		<listentry>
			<media_url><![CDATA[http://download.opensuse.org/update/tumbleweed/]]></media_url>
			<alias>download.opensuse.org-tumbleweed</alias>
			<name>Main Update Repository</name>
		</listentry>
	</add_on_products>
</add-on>
<services-manager>
	<services>
		<enable config:type="list">
			<service>sshd</service>
		</enable>
	</services>
</services-manager>
<networking>
	<backend>wicked</backend>
	<keep_install_network config:type="boolean">false</keep_install_network>
	<interfaces config:type="list">
		<interface>
			<device>${iface}</device>
			<startmode>auto</startmode>
			<bootproto>dhcp</bootproto>
		</interface>
	</interfaces>
</networking>
<users config:type="list">
	<user>
		<username>root</username>
		<user_password>${encrypted_root_password}</user_password>
		<encrypted config:type="boolean">true</encrypted>
	</user>
	<user>
		<username>user</username>
	</user>
</users>
<scripts>
	<chroot-scripts config:type="list">
		<script>
			<chrooted config:type="boolean">true</chrooted>
			<source><![CDATA[
systemctl enable transactional-update.timer transactional-update-cleanup.timer rebootmgr.service
]]>
			</source>
		</script>
	</chroot-scripts>
</scripts>
<files config:type="list">
	<file>
		<file_path>/etc/ssh/sshd_config.d/50custom.conf</file_path>
			<file_contents>
<![CDATA[ChallengeResponseAuthentication no
PasswordAuthentication no
PermitRootLogin no
PrintMotd no
]]>
		</file_contents>
	</file>
	<file>
		<file_path>/home/user/.ssh/</file_path>
		<file_owner>user</file_owner>
		<file_permissions>0700</file_permissions>
	</file>
	<file>
		<file_path>/home/user/.ssh/authorized_keys</file_path>
		<file_owner>user</file_owner>
                <file_contents>
<![CDATA[${authorized_key}
]]>
		</file_contents>
	</file>
</files>
<kdump>
	<add_crash_kernel config:type="boolean">false</add_crash_kernel>
</kdump>
<firewall>
	<log_denied_packets>unicast</log_denied_packets>
	<zones config:type="list">
		<zone>
			<name>public</name>
			<interfaces config:type="list">
				<interface>${iface}</interface>
			</interfaces>
			<services config:type="list">
				<service>ssh</service>
			</services>
		</zone>
	</zones>
</firewall>
</profile>
