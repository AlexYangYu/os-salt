# vi: set ft=yaml.jinja :

{% if 'rabbitmq-ram' in grains['roles'] %}
{% set disc_host = salt['mine.get']('roles:rabbitmq-disc', 'grains.items', 'grain').values()[0]['host'] %}
join_cluster:
    rabbitmq_cluster.join:
        - name: rabbit@{{ disc_host }}
        - user: rabbit
        - host: {{ disc_host }} 
        - ram_node: True
{% endif %}

{% if 'rabbitmq-disc' in grains['roles'] %}
sleep:
    cmd.run:
        - name: sleep 5

set_ha_policy:
    rabbitmq_policy.present:
        - name: HA
        - pattern: '^(>!amq\.).*'
        - definition: '{"ha-mode": "all"}'
{% endif %}
