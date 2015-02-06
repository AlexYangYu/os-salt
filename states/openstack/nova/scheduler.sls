# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.nova.configuration

nova-scheduler:
    pkg.installed:
        - name: nova-scheduler
        - refresh: True
        - require_in:
            - file: nova-conf
    service.running:
        - name: nova-scheduler
        - enable: True
