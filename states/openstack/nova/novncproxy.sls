# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.nova.configuration

nova-novncproxy:
    pkg.installed:
        - name: nova-novncproxy
        - refresh: True
        - require_in:
            - file: nova-conf
    service.running:
        - name: nova-novncproxy
        - enable: True
