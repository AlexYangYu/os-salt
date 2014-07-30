neutron-conf:
  file.recurse:
    - name: /etc/neutron
    - source: salt://openstack/neutron/etc/neutron
    - user: neutron 
    - group: neutron
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      neutron: {{ pillar['neutron'] }}
      mq: {{ pillar['message-queue'] }}
      endpoints: {{ pillar['endpoints'] }}
      data: {{ pillar['init-data'] }}
      nova: {{ pillar['nova-controller'] }}
