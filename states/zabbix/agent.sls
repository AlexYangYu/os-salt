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
      debug_level: {{ pillar['zabbix']['agent']['debug_level'] }}
      all_parameters: {{ pillar['zabbix']['agent']['all_parameters'] }} 
    - require:
      - pkg: zabbix-agent
  cmd.run:
    - name: '/bin/echo "zabbix ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/zabbix'
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-agent
      - file: zabbix-agent
