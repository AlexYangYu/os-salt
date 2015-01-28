# vi: set ft=yaml.jinja :

setup_rabbitmq_server:
    salt.state:
        - tgt: 'roles:rabbitmq-*'
        - tgt_type: grain
        - sls: rabbitmq.server

bootstrap_rabbitmq_cluster:
    salt.state:
        - tgt: 'roles:rabbitmq-*'
        - tgt_type: grain
        - sls: rabbitmq.bootstrap_cluster
