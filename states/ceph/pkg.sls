{% set cluster = salt['pillar.get']('ceph:global:cluster') -%}
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
    - require_in:
      - pkg: ceph-pkg

ceph-pkg:
  pkg.installed:
    - name: ceph

ceph-conf:
  file.managed:
    - name: /etc/ceph/{{ cluster }}.conf
    - source: salt://ceph/etc/ceph.conf
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - require:
      - pkg: ceph-pkg
