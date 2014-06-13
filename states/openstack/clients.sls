openstack-clients:
  pkg.installed:
    - pkgs:
      - python-keystoneclient 
      - python-glanceclient
      - python-novaclient
      - python-neutronclient
      - python-cinderclient
      - python-ceilometerclient
      - python-heatclient
      - python-swiftclient
      - python-troveclient
