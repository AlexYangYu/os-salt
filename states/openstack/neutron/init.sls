# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

init_neutron_service:
    cmd.run:
        - name: /bin/bash {{ script_path }}/openstack/neutron.sh
        - unless: test -f {{ script_path }}/run/neutron.init.lock
