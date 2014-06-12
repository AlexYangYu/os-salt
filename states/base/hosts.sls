/etc/hosts:
  file:
    - managed
    - source: salt://base/hosts
    - user: root
    - group: root
    - mode: '0644'
