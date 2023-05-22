FROM debian:buster

RUN apt-get -y update && apt-get -y install mariadb-server \
		mariadb-client

COPY ./tools/create_db.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/wordpress.sql

EXPOSE 3306
	
