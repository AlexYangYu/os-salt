# vi: set ft=yaml.jinja :

setup_haproxy_server:
    salt.state:
        - tgt: 'roles:haproxy' 
        - tgt_type: grain
        - sls: haproxy.server

init_mysql_check_user:
    salt.state:
        - tgt: 'roles:mysql-cluster-donor'
        - tgt_type: grain
        - sls: haproxy.init_check_user
