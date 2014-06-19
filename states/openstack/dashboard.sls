dashboard-packages:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-wsgi
      - openstack-dashboard
    - require_in:
      - file: /etc/openstack-dashboard

dashboard-configuration:
  file.recurse:
    - name: /etc/openstack-dashboard
    - source: salt://openstack/etc/openstack-dashboard
    - user: root 
    - group: root
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      dashboard: {{ pillar['dashboard'] }}
      endpoints: {{ pillar['endpoints'] }}


