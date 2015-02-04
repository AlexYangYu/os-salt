# vi: set ft=yaml.jinja :

{% set cluster = salt['pillar.get']('ceph:global:cluster') -%}
{% set admin_keyring = '/etc/ceph/' + cluster + '.client.admin.keyring' -%}
{% set apt_source = salt['pillar.get']('ceph:source:apt_source') -%}
{% set apt_key = salt['pillar.get']('ceph:source:apt_key') -%}

python-apt:
    pkg.installed:
        - require_in:
            - pkgrepo: ceph-repo

ceph-repo:
    pkgrepo.managed:
        - name: deb http://{{ apt_source }}/ceph trusty main
        - file: /etc/apt/sources.list.d/ceph.list
        - key_url: {{ apt_key }}

ceph-pkgs:
    pkg.installed:
        - pkgs:
            - python-ceph
            - ceph-common
        - require:
            - pkgrepo: ceph-repo 

ceph-client-conf: 
    file.managed:
        - name: /etc/ceph/{{ cluster }}.conf
        - source: salt://ceph/etc/ceph-client.conf
        - user: root
        - group: root
        - mode: '0644'
        - template: jinja
        - require:
            - pkg: ceph-pkgs

ceph-admin-keyring:
    file.managed:
        - name: {{ admin_keyring }}
        - source: salt://ceph/etc/admin.keyring
