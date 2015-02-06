# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.nova.configuration

nova-api:
    pkg.installed:
        - name: nova-api
        - refresh: True
        - require_in:
            - file: nova-conf
    service.running:
        - name: nova-api
        - enable: True
