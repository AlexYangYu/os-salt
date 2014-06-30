#!/bin/bash - 

set -o nounset
set -e

ln -s /usr/share/zabbix /var/www/zabbix

sed -i "s/^post_max_size\ \?=\ \?.*$/post_max_size = 32M/g" /etc/php5/apache2/php.ini
sed -i "s/^max_execution_time\ \?=\ \?.*$/max_execution_time = 300/g" /etc/php5/apache2/php.ini
sed -i "s/^max_input_time\ \?=\ \?.*$/max_input_time = 300/g" /etc/php5/apache2/php.ini
sed -i "s/^\;date.timezone\ \?=$/date.timezone = Asia\/Shanghai/g" /etc/php5/apache2/php.ini


service apache2 restart
