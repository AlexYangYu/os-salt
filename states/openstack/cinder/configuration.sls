# vi: set ft=yaml.jinja :
{% set script_path = pillar['global']['script_path'] %}

cinder-conf:
    file.recurse:
        - name: /etc/cinder
        - source: salt://openstack/cinder/etc/cinder
        - user: cinder
        - group: cinder
        - dir_mode: '0755'
        - file_mode: '0644'
        - template: jinja
        - defaults:
            mysql_host: {{ pillar['ha_cluster']['mariadb_cluster']['endpoint'] }}
            mysql_port: {{ pillar['ha_cluster']['mariadb_cluster']['bind_port'] }}
        - context:
            cinder: {{ pillar['cinder'] }}
            endpoints: {{ pillar['endpoints'] }}
            data: {{ pillar['init-data'] }}

cinder-setup:
    file.managed:
        - name: {{ script_path }}/openstack/cinder.sh
        - source: salt://openstack/cinder/setup/cinder.sh
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
            cinder: {{ pillar['cinder'] }}
            keystone: {{ pillar['keystone'] }}
            data: {{ pillar['init-data'] }}
            endpoints: {{ pillar['endpoints'] }}
