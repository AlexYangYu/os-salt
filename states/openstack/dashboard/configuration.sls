dashboard-conf:
  file.recurse:
    - name: /etc/openstack-dashboard
    - source: salt://openstack/dashboard/etc/openstack-dashboard
    - user: horizon 
    - group: horizon
    - dir_mode: '0755'
    - file_mode: '0644'
    - template: jinja
    - context:
      dashboard: {{ pillar['dashboard'] }}
      endpoints: {{ pillar['endpoints'] }}
