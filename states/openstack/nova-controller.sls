include:
  - openstack.nova-configuration

nova-controller-packages:
  pkg.installed:
    - pkgs:
      - nova-api
      - nova-cert
      - nova-conductor
      - nova-consoleauth
      - nova-novncproxy
      - nova-scheduler
    - require_in:
      - file: /etc/nova
