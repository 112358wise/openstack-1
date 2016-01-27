#!/bin/sh -e

LANG=en_US.utf8

source ~/demo-openrc

neutron router-interface-delete demo-router demo-subnet
neutron subnet-delete demo-subnet
neutron net-delete demo-net
neutron router-delete demo-router

source ~/test-openrc

neutron router-interface-delete test-router test-subnet
neutron subnet-delete test-subnet
neutron net-delete test-net
neutron router-delete test-router
