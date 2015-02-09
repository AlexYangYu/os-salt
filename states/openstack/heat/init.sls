# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

init_heat_service:
    cmd.run:
        - name: /bin/bash {{ script_path }}/openstack/heat.sh
        - unless: test -f {{ script_path }}/run/heat.init.lock
