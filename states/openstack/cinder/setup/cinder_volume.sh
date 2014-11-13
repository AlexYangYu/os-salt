#!/bin/bash - 

# Create a loop device for lvm
pvcreate /dev/sdb
vgcreate cinder-volumes /dev/sdb
