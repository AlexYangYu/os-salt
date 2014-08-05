cinder-conf:
  file.recurse:
    - name: /etc/cinder
    - source: salt://openstack/cinder/etc/cinder
    - user: cinder
    - group: cinder
    - dir_mode: '0700'
    - file_mode: '0644'
    - template: jinja
    - context:
      cinder: {{ pillar['cinder'] }}
      keystone: {{ pillar['keystone'] }}
      mq: {{ pillar['message-queue'] }}
      endpoints: {{ pillar['endpoints'] }}
      data: {{ pillar['init-data'] }}

cinder-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/cinder.sh
    - source: salt://openstack/cinder/setup/cinder.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      cinder: {{ pillar['cinder'] }}
      keystone: {{ pillar['keystone'] }}
      mysql: {{ pillar['mysql'] }}
      data: {{ pillar['init-data'] }}
      endpoints: {{ pillar['endpoints'] }}
