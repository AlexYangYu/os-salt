# vi: set ft=yaml.jinja :

vm.swappiness:
    sysctl.present:
        - value: 0 

net.ipv4.tcp_tw_recycle:
    sysctl.present:
        - value: 1

net.ipv4.tcp_tw_reuse:
    sysctl.present:
        - value: 1
