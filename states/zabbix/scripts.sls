zabbix-scripts:
  file.recurse:
    - name: /etc/zabbix/zabbix_agentd.conf.d
    - source: salt://zabbix/scripts/user_params
    - user: zabbix
    - group: zabbix


custom-scripts:
  file.recurse:
    - name: /opt/cloud.datayes.com/zabbix/scripts
    - source: salt://zabbix/scripts/custom
    - user: zabbix
    - group: zabbix
    - file_mode: '0777'
