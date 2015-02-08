# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

include:
    - openstack.repo
    - openstack.neutron.configuration

neutron-ovs-setup:
    file.managed:
        - name: {{ script_path }}/openstack/neutron_ovs.sh
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
            - neutron-plugin-ml2
            - openvswitch-datapath-dkms
            - ethtool
        - refresh: True
        - require_in:
            - file: neutron-conf
    cmd.run:
        - name: /bin/bash {{ script_path }}/openstack/neutron_ovs.sh
        - require:
            - pkg: neutron-ovs
    service.running:
        - name: neutron-plugin-openvswitch-agent
        - enable: True
        - require:
            - pkg: neutron-ovs 
            - cmd: neutron-ovs
        - watch:
            - file: neutron-conf
