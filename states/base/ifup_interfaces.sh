#!/bin/bash -

# ifup the management interface
ip a | grep {{ network.mgt_interface }} | grep UP
if [ 0 -ne $? ]
then
    ifup {{ network.mgt_interface }}
fi

# set up the default router
if [[ '{{ network.default_route }}' != $(ip r | grep default | awk '{ print $3 }') ]]
then
    ip route del default
    ip route add default via {{ network.default_route }} dev {{ network.default_interface }}
fi

# ifup the storage interface
ip a | grep {{ network.storage_interface }} | grep UP
if [ 0 -ne $? ]
then
    ifup {{ network.storage_interface }} 
fi

# ifup the data interface
ip a | grep {{ network.data_interface }} | grep UP
if [ 0 -ne $? ]
then
    ifup {{ network.data_interface }} 
fi
