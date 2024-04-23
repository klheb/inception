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
    echo "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root'; DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'; FLUSH PRIVILEGES;" | mysql -u root

    #Add a root user on 127.0.0.1 to allow remote connexion 
    #Flush privileges allow to your sql tables to be updated automatically when you modify it
    #mysql -uroot launch mysql command line client
    echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

    #create database and user
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"| mysql -u root

    #import database
    mysql -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"
