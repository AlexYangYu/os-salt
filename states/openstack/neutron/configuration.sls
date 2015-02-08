# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

neutron-conf:
    file.recurse:
        - name: /etc/neutron
        - source: salt://openstack/neutron/etc/neutron
        - user: neutron 
        - group: neutron
        - dir_mode: '0755'
        - file_mode: '0644'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
        - context:
            neutron: {{ pillar['neutron'] }}
            endpoints: {{ pillar['endpoints'] }}
            data: {{ pillar['init-data'] }}
            nova: {{ pillar['nova'] }}

neutron-setup:
    file.managed:
        - name: {{ script_path }}/openstack/neutron.sh
        - source: salt://openstack/neutron/setup/neutron.sh
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
            neutron: {{ pillar['neutron'] }}
            keystone: {{ pillar['keystone'] }}
            data: {{ pillar['init-data'] }}
            endpoints: {{ pillar['endpoints'] }}
