# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

include:
    - openstack.repo
    - openstack.cinder.configuration

cinder-volume:
    pkg.installed:
        - pkgs:
            - cinder-volume
            - lvm2
        - refresh: True
        - require_in:
            - file: cinder-conf
    service.running:
        - name: cinder-volume
        - enable: True

cinder-volume-setup-lvm-iscsi:
    file.managed:
    - name: {{ script_path }}/openstack/cinder_volume.sh
    - source: salt://openstack/cinder/setup/cinder_volume.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      cinder: {{ pillar['cinder'] }}

{% if 'rbd' == pillar['cinder']['default']['default_store'] %}
cinder_keyring:
    cmd.run:
        - name: ceph auth get client.cinder > /etc/ceph/ceph.client.cinder.keyring
        - require:
            - pkg: cinder-volume
{% endif %}

