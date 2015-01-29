# vi: set ft=yaml.jinja :

{% set apt_source = pillar['openstack_repo']['server'] %}
{% set key_url = pillar['openstack_repo']['key_url'] %}
{% set version = pillar['openstack_repo']['version'] %}

python-apt:
    pkg.installed:
        - require_in:
            - pkgrepo: openstack-repo

openstack-repo:
    pkgrepo.managed:
        - name: deb http://{{ apt_source }}/openstack/ubuntu {{ version }} main
        - file: /etc/apt/sources.list.d/openstack.list
        - key_url: {{ key_url }}
