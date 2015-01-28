# vi: set ft=yaml.jinja :

init_rbd_pool_pg_num:
    cmd.run:
        - name: ceph osd pool set rbd pg_num {{ pillar['ceph']['osd']['pool_default_pg_num'] }}

init_data_pool_pg_num:
    cmd.run:
        - name: ceph osd pool set data pg_num {{ pillar['ceph']['osd']['pool_default_pg_num'] }}
        - require:
            - cmd: init_rbd_pool_pg_num

init_metadata_pool_pg_num:
    cmd.run:
        - name: ceph osd pool set metadata pg_num {{ pillar['ceph']['osd']['pool_default_pg_num'] }}
        - require:
            - cmd: init_data_pool_pg_num

init_rbd_pool_size:
    cmd.run:
        - name: ceph osd pool set rbd size {{ pillar['ceph']['osd']['pool_default_size'] }}
        - require:
            - cmd: init_metadata_pool_pg_num

init_data_pool_size:
    cmd.run:
        - name: ceph osd pool set data size {{ pillar['ceph']['osd']['pool_default_size'] }}
        - require:
            - cmd: init_rbd_pool_size

init_metadata_pool_size:
    cmd.run:
        - name: ceph osd pool set metadata size {{ pillar['ceph']['osd']['pool_default_size'] }}
        - require:
            - cmd: init_data_pool_size

sleep:
    cmd.run:
        - name: sleep 5
        - require:
            - cmd: init_metadata_pool_size

init_rbd_pool_pgp_num:
    cmd.run:
        - name: ceph osd pool set rbd pgp_num {{ pillar['ceph']['osd']['pool_default_pgp_num'] }}
        - require:
            - cmd: sleep

init_data_pool_pgp_num:
    cmd.run:
        - name: ceph osd pool set data pgp_num {{ pillar['ceph']['osd']['pool_default_pgp_num'] }}
        - require:
            - cmd: init_rbd_pool_pgp_num

init_metadata_pool_pgp_num:
    cmd.run:
        - name: ceph osd pool set metadata pgp_num {{ pillar['ceph']['osd']['pool_default_pgp_num'] }}
        - require:
            - cmd: init_data_pool_pgp_num
