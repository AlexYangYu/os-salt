# vi: set ft=yaml.jinja :

{% set admin_pass = pillar['mariadb']['admin_pass'] %}
{% set port = pillar['mariadb']['server']['port'] %}
{% set conn_if = pillar['ha_cluster']['mariadb_cluster']['conn_interface'] %}
{% set check_user = pillar['ha_cluster']['mariadb_cluster']['check_user'] %}
{% set check_pass = pillar['ha_cluster']['mariadb_cluster']['check_pass'] %}

mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "grant process on *.* to '{{ check_user }}'@'localhost' identified by '{{ check_pass }}';":
    cmd.run:
        - unless: mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "SELECT User FROM mysql.user where User='{{ check_user }}' and Host='localhost'" | grep haproxy
        - require_in:
            - cmd: flush_privileges

flush_privileges:
    cmd.run:
        - name: mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "FLUSH PRIVILEGES;"
