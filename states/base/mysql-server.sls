mysql-server-packages:
  pkg.installed:
    - name: mysql-server 

mysql-server-setup:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/mysql.sh
    - source: salt://openstack/setup_scripts/mysql.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      mysql: {{ pillar['mysql'] }}
