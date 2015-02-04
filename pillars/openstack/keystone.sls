# vi: set ft=yaml.jinja :

keystone:
    default:
        debug: false
        verbose: false
        admin_token: ADMIN
        public_interface: em2 
        admin_interface: em2 
        bind_host: 0.0.0.0
        compute_port: 8774
        admin_port: 135357
        public_port: 15000
        log_file: keystone.log
        log_dir: /var/log/keystone
        rabbitmq_ha: True
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
        mysql_db: keystone 
        idle_timeout: 300
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
        driver: keystone.token.persistence.backends.memcache.Token
        caching: true
    memcache:
        servers: 127.0.0.1:11211
