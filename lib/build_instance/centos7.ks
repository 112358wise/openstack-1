install
url --url="http://ip.add.re.ss/centos7/"
network --bootproto=dhcp --hostname=centos7 --device=eth0 --activate
rootpw password
text
firstboot --disable
firewall --disabled
selinux --disabled
keyboard jp106
lang en_US
reboot
timezone --isUtc Asia/Tokyo
bootloader --location=mbr
zerombr
clearpart --all --initlabel
part /boot --asprimary --fstype="xfs" --size=512 --ondisk=vda
part swap --fstype="swap" --size=4096 --ondisk=vda
part / --fstype="xfs" --grow --size=1 --ondisk=vda
%packages --nobase --ignoremissing
@core
%end
