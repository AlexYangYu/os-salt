# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

setup_mariadb_client:
    salt.state:
        - tgt: 'roles:mysql-client'
        - tgt_type: grain
        - sls: mariadb.client

setup_mariadb_cluster:
    salt.state:
        - tgt: 'roles:mysql-cluster'
        - tgt_type: grain
        - sls: mariadb.cluster

init_mariadb_server:
    salt.function:
        - tgt: 'roles:mysql-cluster'
        - tgt_type: grain
        - arg:
            - bash {{ script_path }}/mariadb/init.sh
        - require:
            - salt: setup_mariadb_cluster

bootstrap_mariadb_cluster:
    salt.state:
        - tgt: 'roles:mysql-cluster'
        - tgt_type: grain
        - sls: mariadb.cluster-bootstrap
        - require:
            - salt: init_mariadb_server
