apt-source:
  file.managed:
    - name: /etc/apt/sources.list
    - source: salt://base/sources.list
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - defaults:
      apt_source: {{ pillar['source']['apt_source'] }}
    - require:
      - cmd: ifup_interfaces
