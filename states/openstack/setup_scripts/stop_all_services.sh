#!/bin/bash - 

# keystone
salt '*' cmd.run "service keystone stop"

# glance
salt '*' cmd.run "service glance-api stop"
salt '*' cmd.run "service glance-registry stop"

# nova
salt '*' cmd.run "service nova-api stop"
salt '*' cmd.run "service nova-cert stop"
salt '*' cmd.run "service nova-conductor stop"
salt '*' cmd.run "service nova-consoleauth stop"
salt '*' cmd.run "service nova-novncproxy stop"
salt '*' cmd.run "service nova-scheduler stop"
salt '*' cmd.run "service nova-compute stop"

# neutron
salt '*' cmd.run "service neutron-server stop"
salt '*' cmd.run "service neutron-dhcp-agent stop"
salt '*' cmd.run "service neutron-l3-agent stop"
salt '*' cmd.run "service neutron-metadata-agent stop"
salt '*' cmd.run "service neutron-metering-agent stop"
salt '*' cmd.run "service neutron-plugin-openvswitch-agent stop"
salt '*' cmd.run "service neutron-lbaas-agent stop"

# cinder
salt '*' cmd.run "service cinder-api stop"
salt '*' cmd.run "service cinder-volume stop"
salt '*' cmd.run "service cinder-scheduler stop"

# heat
salt '*' cmd.run "service heat-api stop"
salt '*' cmd.run "service heat-engine stop"
salt '*' cmd.run "service heat-api-cfn stop"

# others
salt '*' cmd.run "service apache2 restart"
salt '*' cmd.run "service memcached restart"
