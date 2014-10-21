{% set cluster = salt['grains.get']('environment', 'ceph') -%}

python-apt:
  pkg.installed:
    - require_in:
      - pkgrepo: ceph-repo

ceph-repo:
  pkgrepo.managed:
    - name: deb http://apt-server/ceph trusty main
    - file: /etc/apt/sources.list.d/ceph.list
    - key_url: https://raw.github.com/ceph/ceph/master/keys/release.asc
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
