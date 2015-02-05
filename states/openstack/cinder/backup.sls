# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.cinder.configuration

cinder-backup:
    pkg.installed:
        - name: cinder-backup
        - require_in:
            - file: cinder-conf
    service.running:
        - name: cinder-backup
        - enable: True

{% if 'rbd' == pillar['cinder']['default']['default_store'] %}
cinder_backup_keyring:
    cmd.run:
        - name: ceph auth get client.cinder-backup > /etc/ceph/ceph.client.cinder-backup.keyring
        - require:
            - pkg: cinder-backup
{% endif %}
