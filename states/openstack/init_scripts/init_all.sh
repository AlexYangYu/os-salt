#!/bin/bash - 

set -o nounset
set -e

function init() {
    echo "Initialize $1"
    if [ -f $1 ]
    then
        source $1
    fi
}

init mysql.sh
init rabbitmq.sh
init keystone.sh
init glance.sh
init nova.sh
init neutron.sh
init cinder_volume.sh
init cinder.sh
init heat.sh
