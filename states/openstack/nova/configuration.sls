# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

nova-conf:
    file.recurse:
        - name: /etc/nova
        - source: salt://openstack/nova/etc/nova
        - user: nova 
        - group: nova 
        - dir_mode: '0755'
        - file_mode: '0644'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
        - context:
            nova: {{ pillar['nova'] }}
            endpoints: {{ pillar['endpoints'] }}
            data: {{ pillar['init-data'] }}

nova-setup:
    file.managed:
        - name: {{ script_path }}/openstack/nova.sh
        - source: salt://openstack/nova/setup/nova.sh
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
            nova: {{ pillar['nova'] }}
            keystone: {{ pillar['keystone'] }}
            data: {{ pillar['init-data'] }}
            endpoints: {{ pillar['endpoints'] }}
