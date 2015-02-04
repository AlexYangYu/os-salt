# vi: set ft=yaml.jinja :

{% if 'rbd' == pillar['glance']['default']['default_store'] %}
{% set pool = pillar['glance']['rbd_store']['pool'] %}
{% set pg_num = pillar['ceph']['osd']['pool_default_pg_num'] %}
create_glance_pool:
    cmd.run:
        - name: ceph osd pool create {{ pool }} {{ pg_num }}

init_glance_pool:
    cmd.run:
        - name: ceph auth get-or-create client.glance mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool={{ pool }}'
        - require:
            - cmd: create_glance_pool
{% endif %}
