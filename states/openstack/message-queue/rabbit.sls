rabbitmq-server:
  pkg.installed


rabbit-setup-scripts:
  file:
    - managed
    - name: /opt/cloud.datayes.com/openstack/setup_scripts/rabbitmq.sh
    - source: salt://openstack/message-queue/setup/rabbitmq.sh
    - makedirs: True
    - user: root
    - group: root
    - mode: '0744'
    - template: jinja
    - context:
      mq : {{ pillar['message-queue'] }}
