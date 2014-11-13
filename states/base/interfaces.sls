{% set host = salt['config.get']('host') %}
{% set interfaces =  salt['pillar.get']('nodes:' + host + ':interfaces') %}
{% set external_interface = salt['pillar.get']('network:external_interface') %}

/etc/network/interfaces:
  file.managed:
    - source: salt://base/interfaces
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

{% for interface in interfaces %}

{% if interface == external_interface %}
{% else %}
ifup {{ interface }}:
  cmd.run:
    - unless: ip a show {{ interface }} | grep UP
    - require:
      - file: /etc/network/interfaces
    - require_in:
      - file: apt-source
{% endif %}

{% endfor %}
