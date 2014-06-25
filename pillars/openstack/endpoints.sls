endpoints:
  region: RegionOne
  keystone:
    public:
      protocol: http
      host: controller
      port: 5000
      version: v2.0
    admin:
      protocol: http
      host: controller
      port: 35357 
      version: v2.0
  glance_api:
    public:
      protocol: http
      host: controller
      port: 9292
    admin:
      protocol: http
      host: controller
      port: 9292
  glance_registry:
    public:
      protocol: http
      host: controller
      port: 9191
    admin:
      protocol: http
      host: controller
      port: 9191
  neutron:
    public:
      protocol: http
      host: controller
      port: 9696 
    admin:
      protocol: http
      host: controller
      port: 9696 
  nova:
    public:
      protocol: http
      host: controller
      port: 8774 
      version: v2
    admin:
      protocol: http
      host: controller
      port: 8774 
      version: v2
  cinder_v1:
    public:
      protocol: http
      host: controller
      port: 8776 
      version: v1
    admin:
      protocol: http
      host: controller
      port: 8776 
      version: v1
  cinder_v2:
    public:
      protocol: http
      host: controller
      port: 8774 
      version: v2
    admin:
      protocol: http
      host: controller
      port: 8774 
      version: v2
  heat_api:
    public:
      protocol: http
      host: controller
      port: 8004
      version: v1
    admin:
      protocol: http
      host: controller
      port: 8004 
      version: v1
  heat_cfn:
    public:
      protocol: http
      host: controller
      port: 8000
      version: v1
    admin:
      protocol: http
      host: controller
      port: 8000 
      version: v1
  novnc:
    host: 10.22.129.21 
    port: 6080
