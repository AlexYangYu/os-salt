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
