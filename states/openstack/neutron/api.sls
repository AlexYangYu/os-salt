# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.neutron.configuration

neutron-api-packages:
    pkg.installed:
        - pkgs:
            - neutron-server
            - neutron-plugin-ml2
        - refresh: True
        - require_in:
            - file: neutron-conf
    service.running:
        - name: neutron-server
        - enable: True

neutron-core-plugin-conf:
    file.managed:
        - name: /etc/default/neutron-server
        - source: salt://openstack/neutron/etc/neutron-server
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - template: jinja
        - context:
            neutron: {{ pillar['neutron'] }}
        - require:
            - pkg: neutron-api-packages
