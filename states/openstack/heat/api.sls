# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.heat.configuration

heat-api:
    pkg.installed:
        - name: heat-api
        - require_in:
            - file: heat-configuration
        - refresh: True
    service.running:
        - name: heat-api
        - enable: True
