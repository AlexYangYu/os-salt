# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.neutron.configuration

neutron-metering:
    pkg.installed:
        - pkgs:
            - neutron-metering-agent
        - require_in:
            - file: neutron-conf
        - refresh: True
    service.running:
        - name: neutron-metering-agent
        - enable: True
        - require:
            - pkg: neutron-metering
        - watch:
            - file: neutron-conf
