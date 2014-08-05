include:
  - openstack.neutron.configuration

neutron-api-packages:
  pkg.installed:
    - pkgs:
      - neutron-server
      - neutron-plugin-ml2
    - require_in:
      - file: neutron-conf
    - require:
      - cmd: update-apt-index
  service.running:
    - name: neutron-server
    - enable: True

neutron-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/neutron.sh
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

neutron-core-plugin-conf:
  file.managed:
    - name: /etc/default/neutron-server
    - source: salt://openstack/neutron/etc/neutron-server
    - makedirs: True
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - context:
      neutron: {{ pillar['neutron'] }}
    - require:
      - pkg: neutron-api-packages
