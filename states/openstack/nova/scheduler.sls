include:
  - openstack.nova.configuration

nova-scheduler:
  pkg.installed:
    - name: nova-scheduler
    - require_in:
      - file: nova-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: nova-scheduler
    - enable: True
