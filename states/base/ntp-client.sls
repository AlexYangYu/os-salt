ntp-client:
  cron.present:
    - name: /usr/sbin/ntpdate wx-ntp & /sbin/hwclock --systohc
    - user: root
    - minute: '*/5'
