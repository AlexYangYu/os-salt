# vi: set ft=yaml.jinja :

include:
    - openstack.repo
    - openstack.dashboard.configuration

apache-dashboard:
    pkg.installed:
        - pkgs:
            - apache2
            - libapache2-mod-wsgi
            - openstack-dashboard
            - memcached
        - require_in:
            - file: dashboard-conf
        - refresh: True
    service.running:
        - name: apache2
        - enable: True
