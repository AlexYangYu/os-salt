include:
  - salt.minion

/etc/salt/grains:
  file.managed:
    - template: jinja
    - source: salt://salt/etc/grains
    - require:
      - pkg: salt-minion
