setup_mariadb_client:
  salt.state:
    - tgt: 'roles:mysql-client'
    - tgt_type: grain
    - sls: mariadb.client
