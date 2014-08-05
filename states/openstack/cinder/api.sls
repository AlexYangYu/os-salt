include:
  - openstack.cinder.configuration

cinder-api:
  pkg.installed:
    - name: cinder-api
    - require_in:
      - file: cinder-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: cinder-api
    - enable: True
