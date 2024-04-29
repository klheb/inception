#mandatory
FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y mariadb-server

# Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

RUN mkdir -p /var/lib/mysql && \
    chown mysql:mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql

#COPY ./tools/init.sql /docker-entrypoint-initdb.d/init.sql

# Configuration personnalisée de MariaDB
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#mandatory
EXPOSE 3306

COPY ./tools/create_db.sh /usr/local/bin/
# COPY ./conf/wordpress.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/create_db.sh
# RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/local/bin/create_db.sh" ]

#launch mariadb and bind address to listen globally
# CMD ["mysqld", "--bind-address=0.0.0.0"]
