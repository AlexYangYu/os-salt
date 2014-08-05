include:
  - openstack.nova.configuration

nova-novncproxy:
  pkg.installed:
    - name: nova-novncproxy
    - require_in:
      - file: nova-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: nova-novncproxy
    - enable: True
