zabbix:
  agent:
    server: zbx-server 
    debug_level: 3
    all_parameters: 1
  server:
    listen_ip: 0.0.0.0
    listen_port: 10051
    debug_level: 3
    db_host: localhost
    db_port: 3306
    db_name: zabbix
    db_user: zabbix
    db_pass: zabbix_pass
  web:
    port: 8110
    dir: /usr/share/zabbix
