cinder-configuration:
  file.recurse:
    - name: /etc/cinder
    - source: salt://openstack/etc/cinder
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
