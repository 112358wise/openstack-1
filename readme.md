公式ドキュメントの内容を可能な限りシェルスクリプトにしたものです。
設定は上書きされるようにしていますが、DBが存在する場合など基本的にエラー処理はほとんど考慮していないです。
http://docs.openstack.org/kilo/install-guide/install/yum/content/


# ストレージノードの構成は事前に手動で実施
```
/dev/vdb1 -> cinder
/dev/vdc -> swift
/dev/vdd -> swift
```

- Cinder用の構成
```sh
# Install lvm packeage
yum -y install lvm2
# Make a Partition (type : 8e)
fdisk /dev/vdb
# Make sure that you create a lvm volume  before you run this script
# Note : If your system uses a different device name, adjust these steps accordingly.
# Create the LVM physical volume
pvcreate /dev/vdb1
# Create the LVM volume group cinder-volumes:
# The Block Storage service creates logical volumes in this volume group.
#
vgcreate cinder-volumes /dev/vdb1
#
# Edit the /etc/lvm/lvm.conf file and complete the following actions:
#
# In the devices section, add a filter that accepts the /dev/vdb device and rejects all other devices:
#
 devices {
 ...
 filter = [ "a/vdb/", "r/.*/"]
```

- swiftの構成
```sh
# Prerequisite
# - Copy the contents of the /etc/hosts file from the controller node and add the following to it:
# - Install and configure NTP using the instructions
# - Format the /dev/vdx1 and /dev/vdx1 partitions as XFS:
mkfs.xfs -f /dev/vdc
mkfs.xfs -f /dev/vdd
mkdir -p /srv/node/vdc
mkdir -p /srv/node/vdd
# Edit the /etc/fstab file and add the following to it:
echo "/dev/vdc /srv/node/vdc xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" >> /etc/fstab
echo "/dev/vdd /srv/node/vdd xfs noatime,nodiratime,nobarrier,logbufs=8 0 2" >> /etc/fstab
# Mount the devices:
mount /srv/node/vdc
mount /srv/node/vdd
```
