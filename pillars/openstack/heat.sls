heat:
  default:
    debug: true
    verbose: true
    heat_stack_user_role: heat_stack_user
    num_engine_workers: 1
    notification_driver: heat.openstack.common.notifier.rpc_notifier
  database:
    mysql_user: heat
    mysql_pass: heat_pass
    mysql_host: controller
    mysql_db: heat
    max_pool_size: 30
    max_retries: -1
    max_overflow: 60
