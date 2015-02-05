# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.cinder.configuration

cinder-api:
    pkg.installed:
        - name: cinder-api
        - require_in:
            - file: cinder-conf
    service.running:
        - name: cinder-api
        - enable: True
