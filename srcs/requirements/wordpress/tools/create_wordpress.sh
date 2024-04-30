#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	#download wordpress
	wget https://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	#add env variables
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	# wp config set WP_REDIS_HOST redis --allow-root #I put --allowroot because i am on the root user on my VM
  	# wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	# wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  	# #wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
 	# wp config set WP_REDIS_CLIENT phpredis --allow-root
	# wp plugin install redis-cache --activate --allow-root
    # wp plugin update --all --allow-root
	# wp redis enable --allow-root

	#add admin and another user
	wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --allow-root
    wp user create $WP_SUBSCRIBER_USER $WP_SUBSCRIBER_MAIL --role=author --user_pass=$WP_SUBSCRIBER_PASSWORD --allow-root

fi

exec "$@"
