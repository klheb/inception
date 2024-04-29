#!/bin/bash

# Wait for 10 seconds to ensure everything is ready
sleep 10

mkdir -p /run/php/
chown www-data:www-data /run/php/
cd /var/www/html

# Check if wp-config.php file exists
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress is already set up!"
else
    echo "Setting up WordPress"
    sleep 10

    /usr/local/bin/wp-cli.phar core download --allow-root
                                --path='/var/www/html'


    # Create WordPress configuration file
    /usr/local/bin/wp-cli.phar config create --allow-root \
                               --dbname=$MYSQL_DATABASE \
                               --dbuser=$MYSQL_USER \
                               --dbpass=$MYSQL_PASSWORD \
                               --dbhost=$MYSQL_HOST \
                               --path='/var/www/html'

    
    # Set appropriate permissions for wp-config.php file
    chmod 777 /var/www/html/wp-config.php

    # Install WordPress
    /usr/local/bin/wp-cli.phar core install --allow-root \
                               --url=$URL\
                               --title="$TITLE" \
                               --admin_user=$WP_ADMIN_USER \
                               --admin_password=$WP_ADMIN_PASSWORD \
                               --admin_email=$WP_ADMIN_MAIL \
                               --path='/var/www/html'

    # Create an additional user
    /usr/local/bin/wp-cli.phar user create $WP_SUBSCRIBER_USER $WP_SUBSCRIBER_MAIL \
                             --allow-root \
                             --role=author \
                             --user_pass=$WP_SUBSCRIBER_PASSWORD \
                             --path='/var/www/html'

    chown -R root:root /var/www/html
    
    echo "WordPress is running!"

fi
# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F -R
