# vi: set ft=yaml.jinja :

haproxy:
    pkg.installed: []
    file.managed:
        - name: /etc/haproxy/haproxy.cfg
        - source: salt://haproxy/etc/haproxy.cfg
        - user: root
        - group: root
        - mode: 644
        - template: jinja
        - context:
            haproxy: {{ pillar['haproxy'] }}
            ha_cluster: {{ pillar['ha_cluster'] }}
    cmd.run:
        - name: sed -i "s/^ENABLED=0$/ENABLED=1/g" /etc/default/haproxy
        - onlyif: test -f /etc/default/haproxy
    service.running:
        - enable: True
        - require:
            - pkg: haproxy
            - cmd: sed -i "s/^ENABLED=0$/ENABLED=1/g" /etc/default/haproxy
        - watch:
            - file: haproxy
