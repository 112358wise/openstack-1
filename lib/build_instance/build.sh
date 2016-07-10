#!/bin/bash
if [[ $# -ne 1 ]];
then
   echo "Usage : $0 <hostname>"
   exit 1;
fi
vcpus=2
ram=2048
location=http://ip.add.re.ss2/centos7/
host=$1
qemu-img create -f qcow2 /tmp/${host}.qcow2 10G
virt-install --name ${host} \
    --vcpus ${vcpus} --ram ${ram} \
    --disk /tmp/${host}.qcow2,format=qcow2 \
    --network network=default \
    --nographics \
    --cpu host \
    --os-variant rhel7 \
    --location ${location} \
    --initrd-inject=${host}.ks \
    --extra-args="ks=file:/${host}.ks console=ttyS0,115200"

