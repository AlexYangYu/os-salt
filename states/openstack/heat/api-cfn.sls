# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.heat.configuration

heat-api-cfn:
    pkg.installed:
        - name: heat-api-cfn
        - require_in:
            - file: heat-configuration
        - refresh: True
    service.running:
        - name: heat-api-cfn
        - enable: True
