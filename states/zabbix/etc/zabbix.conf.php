<?php
// Zabbix GUI configuration file
global $DB;

// Valid types are MYSQL, SQLITE3 or POSTGRESQL
$DB["TYPE"]			= 'MYSQL';
$DB["SERVER"]			= '{{ db_host }}';
$DB["PORT"]			= '{{ db_port }}';

// SQLITE3 use full path to file/database: $DB["DATABASE"] = '/var/lib/zabbix/zabbix.sqlite3';
$DB["DATABASE"]			= '{{ db_name }}';
$DB["USER"]			= '{{ db_user }}';
$DB["PASSWORD"]			= '{{ db_pass }}';
// SCHEMA is relevant only for IBM_DB2 database
$DB["SCHEMA"]			= '';

$ZBX_SERVER			= '{{ server }}';
$ZBX_SERVER_PORT		= '{{ port }}';
$ZBX_SERVER_NAME		= '';

$IMAGE_FORMAT_DEFAULT	= IMAGE_FORMAT_PNG;
?>
