/etc/network/interfaces:
  file:
    - managed:
    - source: salt://base/interfaces
    - user: root
    - group: root
    - mode: '0644'
