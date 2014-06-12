/etc/ntp.conf:
  file:
    - managed
    - source: salt://base/ntp.conf
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
    - context:
      address: {{ pillar['address'] }}

ntp:
  pkg.installed
