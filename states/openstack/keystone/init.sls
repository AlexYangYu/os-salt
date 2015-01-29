# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

init_keystone_service:
    cmd.run:
        - name: /bin/bash {{ script_path }}/openstack/keystone.sh
        - unless: test -f {{ script_path }}/run/keystone.init.lock 
