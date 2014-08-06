#!/bin/bash - 

set -o nounset
set -e

if [ -f init_func.sh ]
then
    source init_func.sh
else
    echo "ERROR, Need init_func.sh"
    exit 1
fi

init openstack/rabbitmq.sh
init openstack/keystone.sh
init openstack/glance.sh
init openstack/nova.sh
init openstack/neutron.sh
init openstack/cinder_volume.sh
init openstack/cinder.sh
init openstack/heat.sh
