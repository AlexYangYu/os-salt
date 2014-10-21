{% set cluster = salt['pillar.get']('ceph:global:cluster') -%}
{% set admin_keyring = '/etc/ceph/' + cluster + '.client.admin.keyring' -%}
{% set mon_keyring = '/etc/ceph/' + cluster + '.mon.keyring' -%}
{% set host = salt['config.get']('host') -%}

include:
  - ceph.pkg

get_admin_keyring:
  file.managed:
    - name: {{ admin_keyring }}
    - source: salt://ceph/etc/admin.keyring

get_mon_keyring:
  file.managed:
    - name: {{ mon_keyring }}
    - source: salt://ceph/etc/mon.keyring

import_keyring:
  cmd.run:
    - name: ceph-authtool {{ mon_keyring }} --import-keyring {{ admin_keyring }}
    - unless: ceph-authtool {{ mon_keyring }} --list | grep '^\[client.admin\]'
    - require:
      - file: get_admin_keyring
      - file: get_mon_keyring
      - pkg: ceph-pkg 

gen_mon_map:
  cmd.run:
    - name: monmaptool --create --generate -c /etc/ceph/{{ cluster }}.conf /etc/ceph/monmap
    - unless: test -f /etc/ceph/monmap
    - require: 
      - file: ceph-conf

populate_mon:
  cmd.run:
    - name: ceph-mon --mkfs -i {{ host }} --monmap /etc/ceph/monmap --keyring {{ mon_keyring }}
    - unless: test -d /var/lib/ceph/mon/{{ cluster }}-{{ host }}
    - require:
      - cmd: gen_mon_map

start_monitor:
  cmd.run:
    - name: start ceph-mon id={{ host }}
    - unless: status ceph-mon id={{ host }}
    - require:
      - cmd: populate_mon
