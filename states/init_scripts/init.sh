#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error
set -e 

if [ -f init_func.sh ]
then
    source init_func.sh
else
    echo "ERROR, Need init_func.sh"
    exit 1
fi

init mysql/init.sh
init zabbix/init.sh
init openstack/init.sh
