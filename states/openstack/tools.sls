stop-service-scripts:
  file.managed:
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/stop_all_services.sh
    - source: salt://openstack/setup_scripts/stop_all_services.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
