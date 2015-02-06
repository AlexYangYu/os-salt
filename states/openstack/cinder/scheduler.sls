# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.cinder.configuration

cinder-scheduler:
    pkg.installed:
        - name: cinder-scheduler
        - refresh: True
        - require_in:
            - file: cinder-conf
    service.running:
        - name: cinder-scheduler
        - enable: True
