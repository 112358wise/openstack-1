#!/bin/bash
location=http://192.168.2.10/centos7/
virt-install --name compute1 \
    --vcpus 2 --ram 8192 \
    --disk path=/var/lib/libvirt/images/compute1.qcow2img,size=64,sparse=false,format=qcow2 \
    --disk path=/var/lib/libvirt/images/compute1-1.qcow2,size=64,sparse=false,format=qcow2 \
    --disk path=/var/lib/libvirt/images/compute1-2.qcow2,size=20,sparse=false,format=qcow2 \
    --disk path=/var/lib/libvirt/images/compute1-3.qcow2,size=20,sparse=false,format=qcow2 \
    --network bridge=br0,model=virtio \
    --network bridge=virbr1,model=virtio \
    --network bridge=virbr2,model=virtio \
    --network bridge=virbr3,model=virtio \
    --nographics \
    --cpu host \
    --os-variant rhel7 \
    --location ${location} \
    --initrd-inject=compute1.ks \
    --extra-args="ks=file:/compute1.ks console=ttyS0,115200"
