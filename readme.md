公式ドキュメントの内容を可能な限りシェルスクリプトにしたものです。エラー処理はほとんど考慮していないです。
http://docs.openstack.org/kilo/install-guide/install/yum/content/

Memo: ストレージノードの構成について

## Computeノード兼用で構成

```txt
/dev/sdb1 -> cinder
/dev/sdc1 -> swift
/dev/sdd1 -> swift
```

## Cinder用の構成
```sh
# Make sure that you create a lvm volume  before you run this script
# Note : If your system uses a different device name, adjust these steps accordingly.
#
# Create the LVM physical volume
pvcreate /dev/sdb1

# Create the LVM volume group cinder-volumes:
# The Block Storage service creates logical volumes in this volume group.
#
vgcreate cinder-volumes /dev/sdb1

#
# Edit the /etc/lvm/lvm.conf file and complete the following actions:
#
# In the devices section, add a filter that accepts the /dev/sdb device and rejects all other devices:
#
 devices {
 ...
 filter = [ "a/sdb/", "r/.*/"]
#
```

## swiftの構成
```sh
# Prerequisite
# - Copy the contents of the /etc/hosts file from the controller node and add the following to it:
# - Install and configure NTP using the instructions
# - Format the /dev/sdx1 and /dev/sdx1 partitions as XFS:
   ex) mkfs.xfs /dev/sdc1
       mkfs.xfs /dev/sdd1
       mkdir -p /srv/node/sdc1
       mkdir -p /srv/node/sdd1
# Edit the /etc/fstab file and add the following to it:
      /dev/sdc1 /srv/node/sdc1 xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
      /dev/sdd1 /srv/node/sdd1 xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
# Mount the devices:
       mount /srv/node/sdc1
       mount /srv/node/sdd1
```
