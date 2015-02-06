# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.nova.configuration

nova-cert:
    pkg.installed:
        - name: nova-cert
        - refresh: True
        - require_in:
            - file: nova-conf
    service.running:
        - name: nova-cert
        - enable: True
