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

disable-i386-arch:
  cmd.run:
    - name: dpkg --remove-architecture i386
    - require:
      - file: apt-source

update-apt-index:
  cmd.run:
    - name: apt-get update
    - require:
      - cmd: disable-i386-arch
