nova-conf:
  file.recurse:
    - name: /etc/nova
    - source: salt://openstack/nova/etc/nova
    - user: nova 
    - group: nova 
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      nova: {{ pillar['nova-controller'] }}
      mq: {{ pillar['message-queue'] }}
      endpoints: {{ pillar['endpoints'] }}
      data: {{ pillar['init-data'] }}

nova-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/nova.sh
    - source: salt://openstack/nova/setup/nova.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      nova: {{ pillar['nova-controller'] }}
      keystone: {{ pillar['keystone'] }}
      mysql: {{ pillar['mysql'] }}
      data: {{ pillar['init-data'] }}
      endpoints: {{ pillar['endpoints'] }}
