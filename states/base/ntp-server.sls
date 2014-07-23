ntp:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/ntp.conf
    - source: salt://base/ntp.conf
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - context:
      ntp: {{ pillar['ntp'] }}
  service:
    - running
    - require:
      - file: ntp
      - pkg: ntp 
    - watch:
      - file: ntp
