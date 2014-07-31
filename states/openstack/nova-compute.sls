include:
  - openstack.nova-configuration

nova-compute:
  pkg.installed:
    - pkgs:
      - nova-compute-kvm
      - python-guestfs
    - require_in:
      - file: /etc/nova
    - require:
      - cmd: update-apt-index
  service.running:
    - enable: True
    - watch:
      - pkg: nova-compute
      - file: /etc/nova
    - require:
      - cmd.run: kernel-patch

kernel-patch:
  file.managed:
    - name: /etc/kernel/postinst.d/statoverride
    - source: salt://openstack/etc/statoverride
    - user: root
    - group: root
    - mode: '0755' 
  cmd.run:
    - name: dpkg-statoverride --update --add root root 0644 /boot/vmlinuz-$(uname -r)
    - onlyif: test '-rw-r--r--' != $(ls -l /boot/vmlinuz-$(uname -r) | awk '{print $1}')
