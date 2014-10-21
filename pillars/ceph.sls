ceph:
  global:
    cluster: ceph
    fsid: 5e30f1e7-b80e-4382-9476-38bd4c32ea92
    public_network: 192.168.21.0/24
    cluster_network: 192.168.20.0/24
  client:
    rbd_cache: true
    rbd_cache_size: 134217728
  osd:
    journal_size: 512
    pool_default_size: 3
    pool_default_min_size: 1
    pool_default_pg_num: 1024
    pool_default_pgp_num: 1024
    crush_chooseleaf_type: 1
    filestore_merge_threshold: 40
    filestore_split_multiple: 8
    op_threads: 8
  mon:
    interface: em1 
