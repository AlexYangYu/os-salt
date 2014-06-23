cloud-keyring:
  pkg.installed:
    - name: ubuntu-cloud-keyring

/etc/apt/sources.list.d/openstack-source.list:
  file:
    - managed
    - source: salt://openstack/openstack-source.list
