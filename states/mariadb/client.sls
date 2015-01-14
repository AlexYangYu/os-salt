# vi: set ft=yaml.jinja :

include:
  - mariadb.pkg

mariadb-client:
  pkg.installed:
    - pkgs:
      - mariadb-client
      - python-mysqldb
