glance-conf:
  file.recurse:
    - name: /etc/glance
    - source: salt://openstack/glance/etc/glance
    - user: glance
    - group: glance
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      glance: {{ pillar['glance'] }}
      mq: {{ pillar['message-queue'] }}
      data: {{ pillar['init-data'] }}
      endpoints: {{ pillar['endpoints'] }}

glance-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/glance.sh
    - source: salt://openstack/glance/setup/glance.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      keystone: {{ pillar['keystone'] }}
      glance: {{ pillar['glance'] }}
      mysql: {{ pillar['mysql'] }}
      data: {{ pillar['init-data'] }}
      endpoints: {{ pillar['endpoints'] }}
