cinder:
  default:
    verbose: true
    debug: true
    notification_driver: cinder.openstack.common.notifier.rpc_notifier
  database:
    mysql_user: cinder 
    mysql_pass: cinder_pass
    mysql_host: cloud-t1.datayes.com
    mysql_db: cinder 
    max_pool_size: 30
    max_retries: -1
