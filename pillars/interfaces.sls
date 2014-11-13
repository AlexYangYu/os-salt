nodes:
  mgt-center:
    interfaces:
      em1:
        addr: 10.22.134.29
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com
  ctl01:
    interfaces:
      em1:
        addr: 10.22.134.30
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com
  net01:
    interfaces:
      em1:
        addr: 10.22.134.31
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com
      em2:
        addr: 0.0.0.0
        netmask: 255.255.255.0
      em4:
        addr: 192.168.134.31
        netmask: 255.255.255.0
  net02:
    interfaces:
      em1:
        addr: 10.22.134.32
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com
      em2:
        addr: 0.0.0.0
        netmask: 255.255.255.0
      em4:
        addr: 192.168.134.32
        netmask: 255.255.255.0
  compute01:
    interfaces:
      em1:
        addr: 10.22.134.21
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.21
        netmask: 255.255.255.0
  compute02:
    interfaces:
      em1:
        addr: 10.22.134.22
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.22
        netmask: 255.255.255.0
  compute03:
    interfaces:
      em1:
        addr: 10.22.134.23
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.23
        netmask: 255.255.255.0
  compute04:
    interfaces:
      em1:
        addr: 10.22.134.24
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.24
        netmask: 255.255.255.0
  compute05:
    interfaces:
      em1:
        addr: 10.22.134.25
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.25
        netmask: 255.255.255.0
  compute06:
    interfaces:
      em1:
        addr: 10.22.134.26
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.26
        netmask: 255.255.255.0
  compute07:
    interfaces:
      em1:
        addr: 10.22.134.27
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.27
        netmask: 255.255.255.0
  compute08:
    interfaces:
      em1:
        addr: 10.22.134.28
        netmask: 255.255.255.0
        gateway: 10.22.134.1
        dns_nameservers: 10.22.134.29
        dns_search: t-datayes.com 
      em4:
        addr: 192.168.134.28
        netmask: 255.255.255.0
