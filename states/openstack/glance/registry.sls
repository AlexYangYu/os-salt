# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.glance.configuration

glance-registry:
    pkg.installed:
        - name: glance-registry
        - refresh: True
        - require_in:
            - file: glance-conf
    service.running:
        - name: glance-registry
        - enable: True
