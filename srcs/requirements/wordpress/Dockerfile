#mandatory
FROM debian:buster

#install everything we need
RUN apt-get update && apt-get -y install \
		wget \
		php \
		php-mysql \
		php-fpm
		&& rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& mv wordpress/* /usr/local/bin/ \
	&& rm -rf latest.tar.gz \
	&& rm -rf wordpress
