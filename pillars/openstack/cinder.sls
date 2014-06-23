cinder:
  default:
    verbose: true
    debug: true
    notification_driver: cinder.openstack.common.notifier.rpc_notifier
    auth_strategy: keystone
  database:
    mysql_user: cinder 
    mysql_pass: cinder_pass
    mysql_host: controller
    mysql_db: cinder 
    max_pool_size: 30
    max_retries: -1
