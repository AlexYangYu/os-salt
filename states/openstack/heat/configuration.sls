heat-configuration:
  file.recurse:
    - name: /etc/heat
    - source: salt://openstack/heat/etc/heat
    - user: heat
    - group: heat
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      heat: {{ pillar['heat'] }}
      keystone: {{ pillar['keystone'] }}
      mq: {{ pillar['message-queue'] }}
      endpoints: {{ pillar['endpoints'] }}
      data: {{ pillar['init-data'] }}

heat-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/heat.sh
    - source: salt://openstack/heat/setup/heat.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      keystone: {{ pillar['keystone'] }}
      mysql: {{ pillar['mysql'] }}
      data: {{ pillar['init-data'] }}
      endpoints: {{ pillar['endpoints'] }}
      heat: {{ pillar['heat'] }}
