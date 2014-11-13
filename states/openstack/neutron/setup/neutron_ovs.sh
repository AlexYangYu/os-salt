#!/bin/bash - 

set -o nounset

# Add integration bridge
if [[ '{{ neutron.ovs.integration_bridge }}' != $(ovs-vsctl show | grep Bridge | grep {{ neutron.ovs.integration_bridge }} | awk '{print $2}') ]]
then
    ovs-vsctl add-br {{ neutron.ovs.integration_bridge }}
fi

# Add external bridge
if [[ '{{ neutron.l3.external_network_bridge }}' != $(ovs-vsctl show | grep Bridge | grep {{ neutron.l3.external_network_bridge }} | awk '{print $2}') ]]
then
    ovs-vsctl add-br {{ neutron.l3.external_network_bridge }}
fi

# Add external interface to bridge
ovs-ofctl show {{ neutron.l3.external_network_bridge }}| grep {{ network.external_interface }}
if [ 0 -ne $? ]
then
    ifup {{ network.external_interface }}
    ovs-vsctl add-port {{ neutron.l3.external_network_bridge }} {{ network.external_interface }}
fi
