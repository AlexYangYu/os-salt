# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.nova.configuration

nova-conductor:
    pkg.installed:
        - name: nova-conductor
        - refresh: True
        - require_in:
            - file: nova-conf
    service.running:
        - name: nova-conductor
        - enable: True
