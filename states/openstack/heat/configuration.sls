# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

heat-configuration:
    file.recurse:
        - name: /etc/heat
        - source: salt://openstack/heat/etc/heat
        - user: heat
        - group: heat
        - dir_mode: '0755'
        - file_mode: '0644'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
        - context:
            heat: {{ pillar['heat'] }}
            keystone: {{ pillar['keystone'] }}
            endpoints: {{ pillar['endpoints'] }}
            data: {{ pillar['init-data'] }}

heat-setup:
    file.managed:
        - name: {{ script_path }}/openstack/heat.sh
        - source: salt://openstack/heat/setup/heat.sh
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
            heat: {{ pillar['heat'] }}
