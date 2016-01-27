#!/bin/sh -e

export LANG=en_US.utf8

function get_netid () { neutron net-list | grep $1  | awk '{print $2}'; }


# To generate a key pair
# Most cloud images support public key authentication rather than conventional user name/password authentication.
# Before launching an instance, you must generate a public/private key pair.
#
# Source the admin credentials to gain access to admin-only CLI commands:
source ~/demo-openrc

# Generate and add a key pair:
echo
echo "** Generating key pair...."
echo

nova keypair-add demo-key | tee demo-key.pem
chmod 600 demo-key.pem

# Verify addition of the key pair:
echo
echo "** nova keypair-list"
echo

nova keypair-list

# To launch an instance, you must at least specify the flavor, image name, network,
# security group, key, and instance name.
# A flavor specifies a virtual resource allocation profile which includes processor,
# memory, and storage.
echo
echo "** nova flavor-list"
echo

nova flavor-list

# List available images:
echo
echo "** nova image-list"
echo

nova image-list

# List available networks:
echo
echo "** neutron net-list"
echo

neutron net-list

# List available security groups:
echo
echo "** nova secgroup-list"
echo

nova secgroup-list

# Launch the instance:
echo
echo "** nova boot nova cirros-0.3.4-x86_64"
echo

DEMO_NET_ID=`get_netid demo-net`
nova boot --flavor m1.tiny --image cirros-0.3.4-x86_64 --nic net-id=${DEMO_NET_ID} \
  --security-group default --key-name demo-key demo-instance1

# Check the status of your instance:
echo
echo "** nova list"
echo

nova list

# To access your instance using a virtual console
# Obtain a Virtual Network Computing (VNC) session URL for your instance and access it
# from a web browser:
#echo
#echo "** Virtual Network Computing (VNC) session URL for your instance"
#echo

#nova get-vnc-console demo-instance1 novnc

# To access your instance remotely
# Add rules to the default security group:
# 
# Permit ICMP (ping):
echo
echo "** Permit ICMP (ping):"
echo

nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
# neutron security-group-rule-create --ethertype IPv4 --protocol icmp --remote-ip-prefix 0.0.0.0/0 default


# Permit secure shell (SSH) access:
echo
echo "** Permit secure shell (SSH) access:"
echo

nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
# neutron security-group-rule-create --ethertype IPv4 --protocol tcp --port-range-min 22 --port-range-max 22 --remote-ip-prefix 0.0.0.0/0 default
