# vi: set ft=yaml.jinja :

stop_mysql_instance:
    service.dead:
        - name: mysql

delivery_init_configuration:
    file.managed:
        - name: /etc/mysql/conf.d/cluster.cnf
        - source: salt://mariadb/etc/cluster-init.cnf
        - template: jinja
        - context:
            db: {{ pillar['mariadb'] }}
            cluster: {{ pillar['mariadb_cluster'] }}
        - require:
            - service: stop_mysql_instance

{% if 'mysql_cluster_donor' in grains['roles'] %}
start_donor_node:
    service.running:
        - name: mysql
        - require_in:
            - cmd: wait_b_moment
{% else %}
wait_a_moment:
    cmd.run:
        - name: sleep 5

start_joiner_node:
    service.running:
        - name: mysql
        - require:
             - cmd: wait_a_moment
        - require_in:
             - cmd: wait_b_moment
{% endif %}

wait_b_moment:
    cmd.run:
        - name: sleep 5

delivery_cluster_configuration:
    file.managed:
        - name: /etc/mysql/conf.d/cluster.cnf
        - source: salt://mariadb/etc/cluster.cnf
        - template: jinja
        - context:
            db: {{ pillar['mariadb'] }}
            cluster: {{ pillar['mariadb_cluster'] }}
        - require:
            - cmd: wait_b_moment


{% if 'mysql_cluster_donor' in grains['roles'] %}
wait_c_moment:
    cmd.run:
       - name: sleep 5 
       - require:
           - file: delivery_cluster_configuration

restart_donor_node:
    cmd.run:
        - name: service mysql restart 
{% else %}
restart_joiner_node:
    service.running:
        - name: mysql
        - require:
            - file: delivery_cluster_configuration
{% endif %}


