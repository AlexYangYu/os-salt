dashboard-conf:
  file.recurse:
    - name: /etc/openstack-dashboard
    - source: salt://openstack/dashboard/etc/openstack-dashboard
    - user: root 
    - group: root
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      dashboard: {{ pillar['dashboard'] }}
      endpoints: {{ pillar['endpoints'] }}
