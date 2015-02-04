# vi: set ft=yaml.jinja :

include: 
    - openstack.repo
    - openstack.glance.configuration

glance-api:
    pkg.installed:
        - name: glance-api
        - refresh: True
        - require_in:
            - file: glance-conf
    service.running:
        - name: glance-api
        - enable: True

{% if 'rbd' == pillar['glance']['default']['default_store'] %}
glance_ceph_keyring:
    cmd.run:
        - name: ceph auth get client.glance > /etc/ceph/ceph.client.glance.keyring
        - require:
            - pkg: glance-api
{% endif %}
