glance:
  default:
    debug: true
    verbose: true
    workers: 1
    show_image_direct_url: true
  database:
    mysql_user: glance
    mysql_pass: glance_pass
    mysql_host: controller
    mysql_db: glance
    max_pool_size: 30
    max_retries: -1
    max_overflow: 60
  paste_deploy:
    flavor: keystone+cachemanagement
