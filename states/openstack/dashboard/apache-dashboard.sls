import:
  - openstack.dashboard.configuration

dashboard-packages:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-wsgi
      - openstack-dashboard
    - require_in:
      - file: dashboard-conf
  service.running:
    - name: apache2
    - enable: True
