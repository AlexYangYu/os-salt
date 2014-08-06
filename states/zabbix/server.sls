zabbix-server:
  pkg.installed:
    - name: zabbix-server-mysql
  file.managed:
    - name: /etc/zabbix/zabbix_server.conf 
    - source: salt://zabbix/etc/zabbix_server.conf
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - defaults:
      debug_level: {{ pillar['zabbix']['server']['debug_level'] }}
      listen_ip: {{ pillar['zabbix']['server']['listen_ip'] }}
      listen_port: {{ pillar['zabbix']['server']['listen_port'] }}
      db_name: {{ pillar['zabbix']['server']['db_name'] }}
      db_user: {{ pillar['zabbix']['server']['db_user'] }}
      db_pass: {{ pillar['zabbix']['server']['db_pass'] }}
      db_port: {{ pillar['zabbix']['server']['db_port'] }}
      db_host: {{ pillar['zabbix']['server']['db_host'] }}
    - require:
      - pkg: zabbix-server
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-server
      - file: zabbix-server


zabbix-server-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/zabbix/setup_server.sh
    - source: salt://zabbix/setup/setup_server.sh
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - defaults:
      db_name: {{ pillar['zabbix']['server']['db_name'] }}
      db_user: {{ pillar['zabbix']['server']['db_user'] }}
      db_pass: {{ pillar['zabbix']['server']['db_pass'] }}
      db_port: {{ pillar['zabbix']['server']['db_port'] }}
      db_host: {{ pillar['zabbix']['server']['db_host'] }}
      mysql_admin_user: {{ pillar['mysql']['admin_user'] }}
      mysql_admin_pass: {{ pillar['mysql']['admin_pass'] }}
