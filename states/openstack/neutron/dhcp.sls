# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.neutron.configuration

neutron-dhcp:
    pkg.installed:
        - name: neutron-dhcp-agent
        - refresh: True
        - require_in:
            - file: neutron-conf
    service.running:
        - name: neutron-dhcp-agent
        - enable: True
        - require:
            - pkg: neutron-dhcp
        - watch:
            - file: neutron-conf
