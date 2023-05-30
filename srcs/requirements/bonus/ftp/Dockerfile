FROM debian:buster

RUN apt-get update && apt-get install -y vsftpd \
        && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

# Création de l'utilisateur FTP
RUN adduser --disabled-password --gecos "" $FTP_USER && \
        echo "$FTP_USER:$FTP_PWD" | chpasswd && \
        mkdir /var/www/html && \
        chown -R $FTP_USER:$FTP_USER /var/www/html

EXPOSE 20 21

CMD ["vsftpd", "/etc/vsftpd.conf"]