<?php

/*	phpipam agent config file
 ******************************/

# set connection type
# 	api,mysql;
# ******************************/
$config['type'] = "mysql";

# set agent key
# ******************************/
$config['key'] = "335bdc3f11b1879e010776f6979c053c";

# set scan method and path to ping file
#	ping, fping or pear
# ******************************/
//$config['method'] 	= "pear";
//$config['pingpath'] = "/sbin/ping";

$config['method'] 	= "fping";
$config['pingpath'] = "/bin/ping";

# permit non-threaded checks (default: false)
# ******************************/
$config['nonthreaded'] = false;

# how many concurrent threads (default: 32)
# ****************************************/
$config['threads']  = 32;

# api settings, if api selected
# ******************************/
$config['api']['key'] = "";

# send mail diff
# ******************************/
$config['sendmail'] = false;

# remove inactive DHCP addresses
#
# 	reset_autodiscover_addresses: will remove addresses if description -- autodiscovered -- and is offline
# 	remove_inactive_dhcp		: will remove inactive dhcp addresses
# ******************************/
$config['reset_autodiscover_addresses'] = false;
$config['remove_inactive_dhcp']         = false;


# mysql db settings, if mysql selected
# ******************************/
$config['db']['host'] = "dbhost";
$config['db']['user'] = "username";
$config['db']['pass'] = "password";
$config['db']['name'] = "phpipam";
$config['db']['port'] = 3306;

/**
 *  SSL options for MySQL
 *
 See http://php.net/manual/en/ref.pdo-mysql.php
     https://dev.mysql.com/doc/refman/5.7/en/ssl-options.html

     Please update these settings before setting 'ssl' to true.
     All settings can be commented out or set to NULL if not needed

     php 5.3.7 required
 ******************************/
$config['db']['ssl']        = false;                           // true/false, enable or disable SSL as a whole
$config['db']['ssl_key']    = '/path/to/cert.key';             // path to an SSL key file. Only makes sense combined with ssl_cert
$config['db']['ssl_cert']   = '/path/to/cert.crt';             // path to an SSL certificate file. Only makes sense combined with ssl_key
$config['db']['ssl_ca']     = '/path/to/ca.crt';               // path to a file containing SSL CA certs
$config['db']['ssl_capath'] = '/path/to/ca_certs';             // path to a directory containing CA certs
$config['db']['ssl_cipher'] = 'DHE-RSA-AES256-SHA:AES128-SHA'; // one or more SSL Ciphers
$config['db']['ssl_verify'] = true;                            // Verify Common Name (CN) of server certificate?
