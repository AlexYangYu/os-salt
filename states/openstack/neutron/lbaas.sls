# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.neutron.configuration

neutron-lbaas:
    pkg.installed:
        - name: neutron-lbaas-agent
        - require_in:
            - file: neutron-conf
        - refresh: True
    service.running:
        - name: neutron-lbaas-agent
        - enable: True
        - require:
            - pkg: neutron-lbaas
        - watch:
            - file: neutron-conf
