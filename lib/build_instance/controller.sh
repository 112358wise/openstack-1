#!/bin/bash
location=http://192.168.2.10/centos7/
virt-install --name controller \
    --vcpus 2 --ram 2048 \
    --disk path=/var/lib/libvirt/images/controller.qcow2,size=64,sparse=false,format=qcow2  \
    --network bridge=virbr1,model=virtio \
    --network bridge=virbr2,model=virtio \
    --network bridge=virbr3,model=virtio \
    --network bridge=br0,model=virtio \
    --nographics \
    --cpu host \
    --os-variant rhel7 \
    --location ${location} \
    --initrd-inject=controller.ks \
    --extra-args="ks=file:/controller.ks console=ttyS0,115200"