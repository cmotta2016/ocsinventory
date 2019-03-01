#!/bin/bash
##This lines will config the path ocsreports after the volumes were mounted.
cd /tmp/ocs && rm -rf ocsreports/dbconfig.inc.php
cp -R ocsreports/* /usr/share/ocsinventory-reports/ocsreports
cp binutils/ipdiscover-util.pl /usr/share/ocsinventory-reports/ocsreports/ipdiscover-util.pl
chmod 755 /usr/share/ocsinventory-reports/ocsreports/ipdiscover-util.pl
chmod +w /usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php
chown -R www-data: /usr/share/ocsinventory-reports/
rm -rf /tmp/ocs/*
##End
if [ ! -d "$APACHE_RUN_DIR" ]; then
	mkdir "$APACHE_RUN_DIR"
	chown $APACHE_RUN_USER:$APACHE_RUN_GROUP "$APACHE_RUN_DIR"
fi
if [ -f "$APACHE_PID_FILE" ]; then
	rm "$APACHE_PID_FILE"
fi
/usr/sbin/apache2ctl -D FOREGROUND
