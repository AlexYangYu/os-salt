# vi: set ft=yaml.jinja :

{% if 'rbd' == pillar['nova']['default']['default_store'] %}
{% set pool = pillar['nova']['rbd_store']['pool'] %}
{% set pg_num = pillar['ceph']['osd']['pool_default_pg_num'] %}
create_nova_pool:
    cmd.run:
        - name: ceph osd pool create {{ pool }} {{ pg_num }}
{% endif %}
