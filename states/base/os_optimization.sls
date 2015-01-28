# vi: set ft=yaml.jinja :

vm.swappiness:
    sysctl.present:
        - value: 0 
