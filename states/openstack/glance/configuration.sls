# vi: set ft=yaml.jinja :
{% set script_path = pillar['global']['script_path'] %}

glance-conf:
    file.recurse:
        - name: /etc/glance
        - source: salt://openstack/glance/etc/glance
        - user: glance
        - group: glance
        - dir_mode: '0755'
        - file_mode: '0644'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
        - context:
            glance: {{ pillar['glance'] }}
            data: {{ pillar['init-data'] }}
            endpoints: {{ pillar['endpoints'] }}

glance-setup:
    file.managed:
        - name: {{ script_path }}/openstack/glance.sh
        - source: salt://openstack/glance/setup/glance.sh
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
            glance: {{ pillar['glance'] }}
            data: {{ pillar['init-data'] }}
            endpoints: {{ pillar['endpoints'] }}
            keystone: {{ pillar['keystone'] }}
