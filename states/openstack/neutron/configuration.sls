neutron-conf:
  file.recurse:
    - name: /etc/neutron
    - source: salt://openstack/neutron/etc/neutron
    - user: neutron 
    - group: neutron
    - dir_mode: '0755'
    - file_mode: '0644'
    - template: jinja
    - context:
      neutron: {{ pillar['neutron'] }}
      mq: {{ pillar['message-queue'] }}
      endpoints: {{ pillar['endpoints'] }}
      data: {{ pillar['init-data'] }}
      nova: {{ pillar['nova'] }}

neutron-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/neutron.sh
    - source: salt://openstack/neutron/setup/neutron.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      neutron: {{ pillar['neutron'] }}
      keystone: {{ pillar['keystone'] }}
      mysql: {{ pillar['mysql'] }}
      data: {{ pillar['init-data'] }}
      endpoints: {{ pillar['endpoints'] }}
