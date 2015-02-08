# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.neutron.configuration

neutron-vpnaas:
    pkg.installed:
        - pkgs:
            - neutron-vpn-agent
            - openswan
        - require_in:
            - file: neutron-conf
        - refresh: True
    service.running:
        - name: neutron-vpn-agent
        - enable: True
        - require:
            - pkg: neutron-vpnaas
        - watch:
            - file: neutron-conf
