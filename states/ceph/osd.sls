# vi: set ft=yaml.jinja :

{% set cluster = salt['pillar.get']('ceph:global:cluster') -%}
{% set fsid = salt['pillar.get']('ceph:global:fsid') -%}
{% set host = salt['config.get']('host') -%}
{% set bootstrap_osd_keyring = '/var/lib/ceph/bootstrap-osd/' + cluster + '.keyring' -%}

include:
  - ceph.pkg

{% for dev in salt['pillar.get']('nodes:' + host + ':devs') -%}
{% if dev -%}
{% set journal = salt['pillar.get']('nodes:' + host + ':devs:' + dev + ':journal') -%}

disk_prepare {{ dev }}:
  cmd.run:
    - name: ceph-disk prepare --cluster {{ cluster }} --cluster-uuid {{ fsid }} --fs-type xfs /dev/{{ dev }} /dev/{{ journal }}
    - unless: parted --script /dev/{{ dev }} print | grep 'ceph data'

disk_activate {{ dev }}:
  cmd.run:
    - name: ceph-disk activate /dev/{{ dev }}1
    - onlyif: test -f {{ bootstrap_osd_keyring }}
    - unless: ceph-disk list | egrep "/dev/{{ dev }}1.*active"
    - timeout: 10

{% endif -%}
{% endfor -%}

start ceph-osd-all:
  cmd.run:
    - onlyif: initctl list | grep "ceph-osd-all stop/waiting"
