endpoints:
  region: RegionOne
  keystone:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 5000
      version: v2.0
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 35357 
      version: v2.0
  glance_api:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 9292
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 9292
  glance_registry:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 9191
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 9191
  neutron:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 9696 
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 9696 
  nova:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 8774 
      version: v2
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 8774 
      version: v2
  cinder_v1:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 8774 
      version: v1
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 8774 
      version: v1
  cinder_v2:
    public:
      protocol: http
      host: cloud-t1.datayes.com
      port: 8774 
      version: v2
    admin:
      protocol: http
      host: cloud-t1.datayes.com
      port: 8774 
      version: v2
  novnc:
    host: 10.22.129.21
    port: 6080
