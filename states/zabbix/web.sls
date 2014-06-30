zabbix-web:
  pkg.installed:
    - pkgs:
      - zabbix-frontend-php
      - php5-mysql
  file.managed:
    - name: /etc/zabbix/zabbix.conf.php
    - source: salt://zabbix/etc/zabbix.conf.php
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - defaults:
      server: {{ pillar['zabbix']['agent']['server'] }}
      port: {{ pillar['zabbix']['server']['listen_port'] }}
      db_name: {{ pillar['zabbix']['server']['db_name'] }}
      db_user: {{ pillar['zabbix']['server']['db_user'] }}
      db_pass: {{ pillar['zabbix']['server']['db_pass'] }}
      db_port: {{ pillar['zabbix']['server']['db_port'] }}
      db_host: {{ pillar['zabbix']['server']['db_host'] }}
    - require:
      - pkg: zabbix-web
 
zabbix-web-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/zabbix/setup_web.sh
    - source: salt://zabbix/scripts/setup_web.sh 
    - user: root
    - group: root
    - mode: '0744'
