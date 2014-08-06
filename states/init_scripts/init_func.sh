#!/bin/bash - 

function init() {
    echo "Initialize $1"
    if [ -f $1 ]
    then
        source $1
    fi
}
