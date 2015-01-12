{% set apt_source = salt['pillar.get']('mariadb:source:apt_source') -%}
{% set apt_key = salt['pillar.get']('mariadb:source:apt_key') -%}

software-properties-common:
  pkg.installed:
    - require_in:
      - pkgrepo: mariadb-repo

mariadb-repo:
  pkgrepo.managed:
    - name: deb http://{{ apt_source }}/mariadb/repo/5.5/ubuntu trusty main
    - file: /etc/apt/sources.list.d/mariadb.list
    - key_url: {{ apt_key }}
