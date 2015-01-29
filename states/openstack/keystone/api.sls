# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.memcached
    - openstack.keystone.configuration

keystone-api:
    pkg.installed:
        - name: keystone
        - refresh: Ture
        - require_in:
            - file: keystone-conf
        - require:
            - pkg: memcache
    service.running:
        - name: keystone
        - enable: True
