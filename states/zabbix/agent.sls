zabbix-agent:
  pkg.installed:
    - name: zabbix-agent
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf 
    - source: salt://zabbix/etc/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - defaults:
      server: {{ pillar['zabbix']['agent']['server'] }}
    - require:
      - pkg: zabbix-agent
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-agent
      - file: zabbix-agent
