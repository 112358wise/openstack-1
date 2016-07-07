#!/bin/bash
location=http://192.168.2.10/centos7/
virt-install --name compute2 \
    --vcpus 2 --ram 4096 \
    --disk path=/var/lib/libvirt/images/compute2.qcow2img,size=64,sparse=false,format=qcow2 \
    --disk path=/var/lib/libvirt/images/compute2-1.qcow2,size=64,sparse=false,format=qcow2 \
    --disk path=/var/lib/libvirt/images/compute2-2.qcow2,size=20,sparse=false,format=qcow2 \
    --disk path=/var/lib/libvirt/images/compute2-3.qcow2,size=20,sparse=false,format=qcow2 \
    --network bridge=br0,model=virtio \
    --network bridge=virbr1,model=virtio \
    --network bridge=virbr2,model=virtio \
    --network bridge=virbr3,model=virtio \
    --nographics \
    --cpu host \
    --os-variant rhel7 \
    --location ${location} \
    --initrd-inject=compute2.ks \
    --extra-args="ks=file:/compute2.ks console=ttyS0,115200"
