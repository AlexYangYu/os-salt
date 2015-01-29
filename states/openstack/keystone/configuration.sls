# vi: set ft=yaml.jinja :
{% set script_path = pillar['global']['script_path'] %}

keystone-conf:
    file.recurse:
        - name: /etc/keystone
        - source: salt://openstack/keystone/etc/keystone
        - user: keystone
        - group: keystone
        - dir_mode: '0755'
        - file_mode: '0644'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
        - context:
            keystone: {{ pillar['keystone'] }}

keystone-setup:
    file.managed:
        - name: {{ script_path }}/openstack/keystone.sh
        - source: salt://openstack/keystone/setup/keystone.sh
        - makedirs: True
        - user: root
        - group: root
        - mode: '0744'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
            mysql_admin_user: {{ pillar['mariadb_cluster']['wsrep_sst_user'] }}
            mysql_admin_pass: {{ pillar['mariadb_cluster']['wsrep_sst_pass'] }}
        - context:
            keystone: {{ pillar['keystone'] }}
            data: {{ pillar['init-data'] }}
            endpoints: {{ pillar['endpoints'] }}
