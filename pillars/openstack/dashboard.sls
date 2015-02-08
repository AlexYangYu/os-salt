# vi: set ft=yaml.jinja :

dashboard:
    debug: False
    time_zone: Asia/Shanghai
    bind_interface: em2
    bind_port: 80
    neutron:
        enable_lb: true
        enable_firewall: true 
        enable_quotas: true
        enable_vpn: true 
        profile_support: None
    hyper_features:
        can_set_mount_point: True
        can_set_password: True
