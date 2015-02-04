# vi: set ft=yaml.jinja :

haproxy:
    global:
        maxconn: 4000
    defaults:
        maxconn: 8000
        retries: 3
        http_timeout: 10s
        queue_timeout: 1m
        connect_timeout: 10s
        client_timeout: 10m
        server_timeout: 10m
        check_timeout: 10s
    web:
        enabled: true
        bind_interface: em2
        port: 8001
        user: admin
        pass: admin_pass
