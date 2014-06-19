include:
  - openstack.neutron-configuration

neutron-controller-packages:
  pkg.installed:
    - pkgs:
      - neutron-server
      - neutron-plugin-ml2

neutron-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/neutron.sh
    - source: salt://openstack/setup_scripts/neutron.sh
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
