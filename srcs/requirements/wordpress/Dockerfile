#mandatory
FROM debian:buster

#install everything we need
RUN apt-get update && apt-get -y install \
		wget \
		php \
		php-mysql \
		php-fpm
		&& rm -rf /var/lib/apt/lists/*

#add pool directives in the html directory
COPY ./conf/www.conf php/7.3/fpm/pool.d/

#enable php start
RUN mkdir /run/php

#add the script
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

WORKDIR /var/www/html/

#mandatory
EXPOSE 9000

#F flag to force to stay in foreground: same as daemon off
CMD ["/usr/sbin/php-fpm7.3", "-F"]
