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
            host: glance-api 
            port: 9292
        admin:
            protocol: http
            host: glance-api 
            port: 9292
    glance_registry:
        public:
            protocol: http
            host: glance-registry 
            port: 9191
        admin:
            protocol: http
            host: glance-registry 
            port: 9191
    neutron:
        public:
            protocol: http
            host: neutron-api 
            port: 9696 
        admin:
            protocol: http
            host: neutron-api 
            port: 9696 
    nova:
        public:
            protocol: http
            host: nova-api 
            port: 8774 
            version: v2
        admin:
            protocol: http
            host: nova-api 
            port: 8774 
            version: v2
    cinder_v1:
        public:
            protocol: http
            host: cinder-api 
            port: 8776 
            version: v1
        admin:
            protocol: http
            host: cinder-api 
            port: 8776 
            version: v1
    cinder_v2:
        public:
            protocol: http
            host: cinder-api 
            port: 8774 
            version: v2
        admin:
            protocol: http
            host: cinder-api 
            port: 8774 
            version: v2
    heat_api:
        public:
            protocol: http
            host: heat-api 
            port: 8004
            version: v1
        admin:
            protocol: http
            host: heat-api 
            port: 8004 
            version: v1
    heat_cfn:
        public:
            protocol: http
            host: heat-api 
            port: 8000
            version: v1
        admin:
            protocol: http
            host: heat-api 
            port: 8000 
            version: v1
    novnc:
        host: 10.20.133.34 
        port: 6080
