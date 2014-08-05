include:
  - openstack.cinder.configuration

cinder-volume:
  pkg.installed:
    - pkgs:
      - cinder-volume
      - lvm2
    - require_in:
      - file: cinder-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: cinder-volume
    - enable: True

cinder-volume-setup-lvm-iscsi:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/cinder_volume.sh
    - source: salt://openstack/cinder/setup/cinder_volume.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      cinder: {{ pillar['cinder'] }}
