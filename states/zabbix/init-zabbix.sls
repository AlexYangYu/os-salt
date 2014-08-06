init_zabbix:
  file.managed:
    - name: /opt/cloud.datayes.com/zabbix/init.sh
    - source: salt://zabbix/setup/init.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
