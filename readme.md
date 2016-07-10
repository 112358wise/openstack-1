公式ドキュメントの内容を可能な限りシェルスクリプトにしたものです。
設定は上書きされるようにしていますが、DBが存在する場合など基本的にエラー処理はほとんど考慮していないです。
http://docs.openstack.org/kilo/install-guide/install/yum/content/

Memo: ストレージノードの構成は事前に手動で実施する必要あり（スクリプトではやっていないので）

## Computeノード兼用で構成

```txt
/dev/vdb1 -> cinder
/dev/vdc1 -> swift
/dev/vdd1 -> swift
```

## Cinder用の構成
```sh
# Make sure that you create a lvm volume  before you run this script
# Note : If your system uses a different device name, adjust these steps accordingly.
#
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
#
```

## swiftの構成
```sh
# Prerequisite
# - Copy the contents of the /etc/hosts file from the controller node and add the following to it:
# - Install and configure NTP using the instructions
# - Format the /dev/vdx1 and /dev/vdx1 partitions as XFS:
   ex) mkfs.xfs /dev/vdc1
       mkfs.xfs /dev/vdd1
       mkdir -p /srv/node/vdc1
       mkdir -p /srv/node/vdd1
# Edit the /etc/fstab file and add the following to it:
      /dev/vdc1 /srv/node/vdc1 xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
      /dev/vdd1 /srv/node/vdd1 xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
# Mount the devices:
       mount /srv/node/vdc1
       mount /srv/node/vdd1
```
