�����h�L�������g�̓��e���\�Ȍ���V�F���X�N���v�g�ɂ������̂ł��B�G���[�����͂قƂ�Ǎl�����Ă��Ȃ��ł��B
http://docs.openstack.org/kilo/install-guide/install/yum/content/

Memo: �X�g���[�W�m�[�h�̍\���ɂ���

## Compute�m�[�h���p�ō\��

```txt
/dev/sdb1 -> cinder
/dev/sdc1 -> swift
/dev/sdd1 -> swift
```

## Cinder�p�̍\��
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

## swift�̍\��
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
