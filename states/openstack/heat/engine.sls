# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.heat.configuration

heat-engine:
    pkg.installed:
        - name: heat-engine
        - require_in:
            - file: heat-configuration
        - refresh: True
    service.running:
        - name: heat-engine
        - enable: True
