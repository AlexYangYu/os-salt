# vi: set ft=yaml.jinja :

keepalived:
    pkg.installed:
        - name: keepalived
    file.managed:
        - name: /etc/keepalived/keepalived.conf 
        - source: salt://keepalive/etc/keepalived.conf
        - template: jinja
        - context:
            keepalived: {{ pillar['keepalived'] }}
    service.running:
        - require:
            - pkg: keepalived
        - watch:
            - file: /etc/keepalived/keepalived.conf
