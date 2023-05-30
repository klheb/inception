#!/bin/bash

# Attendre jusqu'à ce que le fichier wp-config-sample.php soit disponible
while [ ! -f /var/www/html/wp-config-sample.php ]; do
  sleep 1
done

# Déplacer wp-config-sample.php vers wp-config.php
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Configuration de WordPress en utilisant les variables d'environnement
sed -i -e "s/database_name_here/$MYSQL_DATABASE/
        s/username_here/$MYSQL_USER/
        s/password_here/$MYSQL_PASSWORD/
        s/localhost/$MYSQL_HOSTNAME/" \
    /var/www/html/wp-config.php

# Démarrage de PHP-FPM
exec php-fpm -F
