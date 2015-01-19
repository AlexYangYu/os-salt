# vi: set ft=yaml.jinja :

{% set admin_pass = pillar['mariadb']['admin_pass'] %}
{% set port = pillar['mariadb']['server']['port'] %}
{% set conn_if = pillar['ha_cluster']['mariadb_cluster']['conn_interface'] %}

{% for grains in salt['mine.get']('roles:haproxy', 'grains.items', 'grain').values() %}
{% set ha_ip = grains.ip_interfaces[conn_if][0] %}
mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "CREATE USER 'haproxy'@'{{ ha_ip }}';":
    cmd.run:
        - onlyif: killall -0 mysqld
{% endfor %}
