#!/bin/bash - 

# Create a loop device for lvm
dd if=/dev/zero of=/opt/cinder-volumes bs=1 count=0 seek=50G
losetup /dev/loop2 /opt/cinder-volumes
pvcreate /dev/loop2
vgcreate cinder-volumes /dev/loop2

echo 'losetup /dev/loop2 /opt/cinder-volumes' >> /etc/rc.local
