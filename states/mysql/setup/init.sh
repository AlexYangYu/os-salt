#!/bin/bash - 

set -o nounset
set -e

if [ -f ../init_func.sh ]
then
    source ../init_func.sh
else
    echo "ERROR, Need init_func.sh"
    exit 1
fi

init mysql.sh
