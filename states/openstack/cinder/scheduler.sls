include:
  - openstack.cinder.configuration

cinder-scheduler:
  pkg.installed:
    - name: cinder-scheduler
    - require_in:
      - file: cinder-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: cinder-scheduler
    - enable: True
