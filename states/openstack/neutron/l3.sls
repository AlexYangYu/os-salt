include:
  - openstack.neutron.configuration

neutron-l3:
  pkg.installed:
    - name: neutron-l3-agent
    - require_in:
      - file: neutron-conf
  service.running:
    - name: neutron-l3-agent
    - enable: True
    - require:
      - pkg: neutron-l3
      - file: neutron-conf

sysctl-conf:
  file.managed:
    - source: salt://openstack/neutron/etc/60-ip-forwarding.conf 
    - name: /etc/sysctl.d/60-ip-forwarding.conf

sysctl-enable:
  cmd.run:
    - name: sysctl -p /etc/sysctl.d/60-ip-forwarding.conf
    - require:
      - file: /etc/sysctl.d/60-ip-forwarding.conf
