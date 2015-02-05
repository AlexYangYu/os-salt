# vi: set ft=yaml.jinja :

{% if 'rbd' == pillar['cinder']['default']['default_store'] %}
{% set pool = pillar['cinder']['rbd_store']['pool'] %}
{% set pg_num = pillar['ceph']['osd']['pool_default_pg_num'] %}
create_cinder_pool:
    cmd.run:
        - name: ceph osd pool create {{ pool }} {{ pg_num }}

init_cinder_user:
    cmd.run:
        - name: ceph auth get-or-create client.cinder mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=volumes, allow rwx pool=vms, allow rx pool=images'
        - require:
            - cmd: create_cinder_pool
{% endif %}


{% if 'rbd' == pillar['cinder']['backup']['store'] %}
{% set b_pool = pillar['cinder']['backup']['pool'] %}
{% set b_pg_num = pillar['ceph']['osd']['pool_default_pg_num'] %}
create_backup_pool:
    cmd.run:
        - name: ceph osd pool create {{ b_pool }} {{ b_pg_num }}

init_cinder_backup_user:
    cmd.run:
        - name: ceph auth get-or-create client.cinder-backup mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=backups'
        - require:
            - cmd: create_backup_pool
{% endif %}
