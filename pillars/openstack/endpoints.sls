# vi: set ft=yaml.jinja :

endpoints:
    region: RegionOne
    keystone:
        public:
            protocol: http
            host: vip-keystone-api
            port: 5000
            version: v2.0
        admin:
            protocol: http
            host: vip-keystone-api 
            port: 35357 
            version: v2.0
    glance_api:
        public:
            protocol: http
            host: vip-glance-api 
            port: 9292
        admin:
            protocol: http
            host: vip-glance-api 
            port: 9292
    glance_registry:
        public:
            protocol: http
            host: vip-glance-registry 
            port: 9191
        admin:
            protocol: http
            host: vip-glance-registry 
            port: 9191
    neutron:
        public:
            protocol: http
            host: vip-neutron-api 
            port: 9696 
        admin:
            protocol: http
            host: vip-neutron-api 
            port: 9696 
    nova:
        public:
            protocol: http
            host: vip-nova-api 
            port: 8774 
            version: v2
        admin:
            protocol: http
            host: vip-nova-api 
            port: 8774 
            version: v2
    cinder_v1:
        public:
            protocol: http
            host: vip-cinder-api 
            port: 8776 
            version: v1
        admin:
            protocol: http
            host: vip-cinder-api 
            port: 8776 
            version: v1
    cinder_v2:
        public:
            protocol: http
            host: vip-cinder-api 
            port: 8776 
            version: v2
        admin:
            protocol: http
            host: vip-cinder-api 
            port: 8776 
            version: v2
    heat_api:
        public:
            protocol: http
            host: vip-heat-api 
            port: 8004
            version: v1
        admin:
            protocol: http
            host: vip-heat-api 
            port: 8004 
            version: v1
    heat_cfn:
        public:
            protocol: http
            host: vip-heat-api 
            port: 8000
            version: v1
        admin:
            protocol: http
            host: vip-heat-api 
            port: 8000 
            version: v1
    novnc:
        host: vip-novnc 
        port: 6080
