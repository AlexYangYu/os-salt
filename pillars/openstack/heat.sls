# vi: set ft=yaml.jinja :

heat:
    default:
        debug: false
        verbose: true
        log_dir: /var/log/heat
        heat_stack_user_role: heat_stack_user
        num_engine_workers: 1
        notification_driver: heat.openstack.common.notifier.rpc_notifier
        bind_interface: em2
        bind_host: 0.0.0.0
        api_bind_port: 18004
        cfn_bind_port: 18000
    database:
        mysql_user: heat
        mysql_pass: heat_pass
        mysql_db: heat
        idle_timeout: 300
        max_pool_size: 30
        max_retries: -1
        max_overflow: 60
