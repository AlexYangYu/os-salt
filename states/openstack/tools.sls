init_all_services:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/init_all.sh
    - source: salt://openstack/init_scripts/init_all.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
