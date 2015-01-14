# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

setup_mariadb_client:
    salt.state:
        - tgt: 'roles:mysql-client'
        - tgt_type: grain
        - sls: mariadb.client

setup_mariadb_server:
    salt.state:
        - tgt: 'roles:mysql-server'
        - tgt_type: grain
        - sls: mariadb.server

init_mariadb_server:
    salt.function:
        - tgt: 'roles:mysql-server'
        - tgt_type: grain
        - arg:
            - bash {{ script_path }}/mariadb/init.sh
        - require:
            - salt: setup_mariadb_server
