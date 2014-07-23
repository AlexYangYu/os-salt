/etc/apt/sources.list:
  file.managed:
    - source: salt://base/sources.list
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - context:
      ntp: {{ pillar['ntp'] }}
