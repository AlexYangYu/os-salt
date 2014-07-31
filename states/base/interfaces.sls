/etc/network/interfaces:
  file.managed:
    - source: salt://base/interfaces
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
      network: {{ pillar['network'] }}

/opt/cloud.datayes.com/openstack/setup_scripts/ifup_interfaces.sh:
  file.managed:
    - source: salt://base/ifup_interfaces.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      network: {{ pillar['network'] }}

ifup_interfaces:
  cmd.run:
    - name: /bin/bash /opt/cloud.datayes.com/openstack/setup_scripts/ifup_interfaces.sh
    - require:
      - file: /etc/network/interfaces
      - file: /opt/cloud.datayes.com/openstack/setup_scripts/ifup_interfaces.sh
