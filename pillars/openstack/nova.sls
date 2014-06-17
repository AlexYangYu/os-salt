nova-controller:
  default:
    verbose: true
    debug: true
    api_workers: 1
  database:
    mysql_user: nova
    mysql_pass: nova_pass
    mysql_host: cloud-t1.datayes.com
    mysql_db: nova
    max_pool_size: 30
    max_retries: -1
    max_overflow: 60
  neutron:
    metadata_proxy_shared_secret: 123456
  vnc:
    vncserver_listen: 0.0.0.0
    vncserver_proxyclient_address: 127.0.0.1
