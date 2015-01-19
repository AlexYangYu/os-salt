# vi: set ft=yaml.jinja :

{% set admin_pass = pillar['mariadb']['admin_pass'] %}
{% set port = pillar['mariadb']['server']['port'] %}
{% set conn_if = pillar['ha_cluster']['mariadb_cluster']['conn_interface'] %}
{% set check_user = pillar['ha_cluster']['mariadb_cluster']['check_user'] %}

{% for grains in salt['mine.get']('roles:haproxy', 'grains.items', 'grain').values() %}
{% set ha_ip = grains.ip_interfaces[conn_if][0] %}
mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "CREATE USER '{{ check_user }}'@'{{ ha_ip }}';":
    cmd.run:
        - unless: mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "SELECT User FROM mysql.user where User='{{ check_user }}' and Host='{{ ha_ip }}'" | grep haproxy
        - require_in:
            - cmd: flush_privileges
{% endfor %}

flush_privileges:
    cmd.run:
        - name: mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "FLUSH PRIVILEGES;"
