# vi: set ft=yaml.jinja :

{% set script_path = pillar['global']['script_path'] %}

include:
    - openstack.repo
    - openstack.nova.configuration

nova-compute:
    pkg.installed:
        - pkgs:
            - nova-compute-kvm
            - python-guestfs
            - sysfsutils
        - refresh: True
        - require_in:
            - file: /etc/nova
    service.running:
        - enable: True
        - watch:
            - pkg: nova-compute
        - file: /etc/nova
        - require:
            - cmd: kernel-patch

kernel-patch:
    file.managed:
        - name: /etc/kernel/postinst.d/statoverride
        - source: salt://openstack/nova/etc/statoverride
        - user: root
        - group: root
        - mode: '0755' 
    cmd.run:
        - name: dpkg-statoverride --update --add root root 0644 /boot/vmlinuz-$(uname -r)
        - onlyif: test '-rw-r--r--' != $(ls -l /boot/vmlinuz-$(uname -r) | awk '{print $1}')

disable-libvirt-defalut-net:
    cmd.run:
        - name: virsh net-destroy default
        - onlyif: virsh net-list | grep default
        - require:
            - pkg: nova-compute

{% if 'rbd' in pillar['nova']['default']['default_store'] %}
cinder_keyring:
    cmd.run:
        - name: ceph auth get-key client.cinder > /etc/ceph/ceph.client.cinder.key
        - require:
            - pkg: nova-compute

secret_file:
    file.managed:
        - name: {{ script_path }}/openstack/secret.xml
        - source: salt://openstack/nova/files/secret.xml
        - makedirs: True
        - file_mode: '0644'
        - template: jinja
        - defaults:
            secret: {{ pillar['cinder']['rbd_store']['secert_uuid'] }}
        - require:
            - cmd: cinder_keyring

set_libvirt_secret:
    cmd.run:
        - name: virsh secret-define --file {{ script_path }}/openstack/secret.xml
        - require:
            - file: secret_file

set_libvirt_secret_value:
    cmd.run:
        - name: virsh secret-set-value --secret {{ pillar['cinder']['rbd_store']['secert_uuid'] }} --base64 $(cat /etc/ceph/ceph.client.cinder.key)
        - require:
            - cmd: set_libvirt_secret
{% endif %}
