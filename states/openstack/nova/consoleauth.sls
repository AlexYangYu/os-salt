include:
  - openstack.nova.configuration

nova-consoleauth:
  pkg.installed:
    - name: nova-consoleauth
    - require_in:
      - file: nova-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: nova-consoleauth
    - enable: True
