include:
  - openstack.nova-configuration

nova-compute-packages:
  pkg.installed:
    - pkgs:
      - nova-compute-kvm
      - python-guestfs
    - require_in:
      - file: /etc/nova

kernel-patch:
  cmd.run:
    - name: dpkg-statoverride  --update --add root root 0644 /boot/vmlinuz-$(uname -r)
    - onlyif: test '-rw-r--r--' -eq $(ls -l /boot/vmlinuz-$(uname -r) | awk '{print $1}')
