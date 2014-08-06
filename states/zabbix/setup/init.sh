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

init zabbix/setup_server.sh
init zabbix/setup_web.sh
