# vi: set ft=yaml.jinja :

rabbitmq-server:
    pkg.installed:
        - name: rabbitmq-server
    service.dead:
        - name: rabbitmq-server 
        - require:
            - pkg: rabbitmq-server
    file.managed:
        - name: /etc/rabbitmq/rabbitmq.config
        - source: salt://rabbitmq/etc/rabbitmq.config
        - template: jinja
        - user: rabbitmq
        - group: rabbitmq
        - context:
            rabbit: {{ pillar['rabbitmq'] }}
        - require:
            - service: rabbitmq-server
 
erlang-cookie:
    file.managed:
        - name: /var/lib/rabbitmq/.erlang.cookie
        - source: salt://rabbitmq/etc/erlang.cookie
        - user: rabbitmq
        - group: rabbitmq
        - mode: 400
        - require:
            - pkg: rabbitmq-server 

install-management-plugin:
    cmd.run:
        - name: rabbitmq-plugins enable rabbitmq_management
        - env:
            - HOME: /usr/lib/erlang
        - require:
            - file: erlang-cookie

start-rabbitmq-server:
    service.running:
        - name: rabbitmq-server
        - require:
            - cmd: install-management-plugin 
