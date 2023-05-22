#!/bin/sh

#create db
mysql_install_db

#start db
/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE"]
then
	echo "database already exist"
else

	#launch installation
	mysql_secure_installation << _EOF_

Y
root4life
root4life
Y
n
Y
Y
_EOF_

	#Add a root user on 127.0.0.1 to allow remote connexion 
	#Flush privileges allow to your sql tables to be updated automatically when you modify it
	#mysql -uroot launch mysql command line client
	echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

	#create database and user
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"| mysql -u root

	#import database
	mysql -u root -p $MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"
