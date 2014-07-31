ntp-client:
  cron.present:
    - name: /usr/sbin/ntpdate ntp-server & /sbin/hwclock --systohc
    - user: root
    - minute: '*/5'
