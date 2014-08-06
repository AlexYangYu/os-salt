init_all_scripts:
  file.recurse:
    - name: /opt/cloud.datayes.com
    - source: salt://init_scripts
    - user: root 
    - group: root
    - dir_mode: '0700'
    - file_mode: '0744'
