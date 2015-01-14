# vi: set ft=yaml.jinja :

{% set admin_pass = pillar['mariadb']['admin_pass'] %}
{% set maintenance_pass = pillar['mariadb']['maintenance_pass'] %}
{% set port = pillar['mariadb']['server']['port'] %}
{% set script_path = pillar['global']['script_path'] %}

include:
    - mariadb.pkg

mariadb-debconf:
    debconf.set:
        - name: mariadb-server
        - data:
            'mysql-server/root_password': {'type':'string','value':{{ admin_pass }}}
            'mysql-server/root_password_again': {'type':'string','value':{{ admin_pass }}}

mariadb-server-pkgs:
    pkg.installed:
        - name: mariadb-server
        - require:
            - debconf: mariadb-debconf
            - pkgrepo: mariadb-repo
    service.running:
        - name: mysql

mariadb-update-maint:
    cmd.run:
        - name: mysql -hlocalhost -P{{ port }} -u root -p{{ admin_pass }} -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '{{ maintenance_pass }}';"
        - onlyif: killall -0 mysqld
        - require:
            - pkg: mariadb-server-pkgs

mariadb-server-configuration:
    file.managed:
        - name: /etc/mysql/my.cnf
        - source: salt://mariadb/etc/my.cnf
        - template: jinja
        - context:
            mysql: {{ pillar['mariadb'] }} 

mariadb-debian-configuration:
    file.managed:
        - name: /etc/mysql/debian.cnf
        - source: salt://mariadb/etc/debian.cnf
        - template: jinja
        - context:
            mysql: {{ pillar['mariadb'] }}

mariadb-setup-scripts:
    file.managed:
        - name: {{ script_path }}/mariadb/init.sh
        - source: salt://mariadb/setup/init.sh
        - makedirs: True
        - user: root
        - group: root
        - mode: '0744'
        - template: jinja
        - context:
            mysql: {{ pillar['mariadb'] }}
