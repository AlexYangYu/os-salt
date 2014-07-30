include:
  - openstack.neutron.configuration

neutron-ovs-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/neutron_ovs.sh
    - source: salt://openstack/neutron/setup/neutron_ovs.sh
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      neutron: {{ pillar['neutron'] }}
      network: {{ pillar['network'] }}

neutron-ovs:
  pkg.installed:
    - pkgs:
      - neutron-plugin-openvswitch-agent
      - openvswitch-datapath-dkms
    - require_in:
      - file: neutron-conf
  cmd.run:
    - name: /bin/bash /opt/cloud.datayes.com/openstack/setup_scripts/neutron_ovs.sh
    - require:
      - pkg: neutron-ovs
  service.running:
    - name: neutron-plugin-openvswitch-agent
    - enable: True
    - require:
      - pkg: neutron-ovs 
      - cmd: neutron-ovs
      - file: neutron-conf
