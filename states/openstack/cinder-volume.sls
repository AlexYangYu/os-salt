cinder-volume-packages:
  pkg.installed:
    - pkgs:
      - lvm2
      - cinder-volume

cinder-volume-setup-lvm-iscsi:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/cinder_volume.sh
    - source: salt://openstack/setup_scripts/cinder_volume.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      cinder: {{ pillar['cinder'] }}
