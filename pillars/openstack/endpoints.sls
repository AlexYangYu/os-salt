endpoints:
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
      protocol: http
      host: cloud-t1.datayes.com
      port: 9191
