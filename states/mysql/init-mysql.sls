init_mysql:
  file.managed:
    - name: /opt/cloud.datayes.com/mysql/init.sh
    - source: salt://mysql/setup/init.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
