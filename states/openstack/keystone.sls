keystone:
  pkg.installed

keystone-conf:
  file.recurse:
    - name: /etc/keystone
    - source: salt://openstack/etc/keystone
    - user: keystone
    - group: keystone
    - dir_mode: '0700'
    - file_mode: '0644'
    - require:
       - pkg: keystone
    - template: jinja
    - context:
      keystone: {{ pillar['keystone'] }}
      mq: {{ pillar['message-queue'] }}

keystone-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/keystone.sh
    - source: salt://openstack/setup_scripts/keystone.sh
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
