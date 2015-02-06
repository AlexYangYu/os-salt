# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.nova.configuration

nova-consoleauth:
    pkg.installed:
        - name: nova-consoleauth
        - refresh: True
        - require_in:
            - file: nova-conf
    service.running:
        - name: nova-consoleauth
        - enable: True
