# vi: set ft=yaml.jinja :

haproxy:
    defaults:
        contimeout: 5000
        clitimeout: 50000
        srvtimeout: 50000
    web:
        enabled: true
        bind_interface: em2
        port: 8001
        user: admin
        pass: admin_pass
