init_openstack:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/init.sh
    - source: salt://openstack/init_scripts/init.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
