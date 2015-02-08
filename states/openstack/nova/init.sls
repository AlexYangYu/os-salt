# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

init_nova_service:
    cmd.run:
        - name: /bin/bash {{ script_path }}/openstack/nova.sh
        - unless: test -f {{ script_path }}/run/nova.init.lock
