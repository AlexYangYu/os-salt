include:
  - openstack.cinder-configuration

cinder-controller-packages:
  pkg.installed:
    - pkgs:
      - cinder-api
      - cinder-scheduler
    - require_in:
      - file: /opt/cloud.datayes.com/openstack/setup_scripts/cinder.sh

cinder-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/cinder.sh
    - source: salt://openstack/setup_scripts/cinder.sh
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
