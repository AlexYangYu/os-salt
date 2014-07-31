keystone:
  default:
    debug: true
    verbose: true
    admin_token: ADMIN 
    bind_host: 0.0.0.0
    log_file: keystone.log
    log_dir: /var/log/keystone
  cache:
    enabled: true
    backend: dogpile.cache.memcached
    backend_argument: url:127.0.0.1
  catalog:
    driver: keystone.catalog.backends.sql.Catalog
  credential:
    driver: keystone.credential.backends.sql.Credential
  database:
    mysql_user: keystone
    mysql_pass: keystone_pass
    mysql_host: mysql-server 
    mysql_db: keystone
    max_pool_size: 30
    max_retries: -1
    max_overflow: 60
  ec2:
    driver: keystone.contrib.ec2.backends.sql.Ec2
  identity:
    driver: keystone.identity.backends.sql.Identity
  policy:
    driver: keystone.policy.backends.rules.Policy
  signing:
    token_format: UUID
  token:
    driver: keystone.token.backends.memcache.Token
    caching: true
  memcache:
    servers: 127.0.0.1:11211
