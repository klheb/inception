#mandatory
FROM debian:buster

#install nginx and ssl
RUN apt-get -y update && apt-get -y install nginx openssl

#generate ssl certificate
#newkey rsa:4096 create a 4096 bits new private key
#x509 to create a self signed certificate instead of a certificate request
#sha256 to sign the certificate
#days 365 to certifiy the certificate for 365 days
#nodes make new key to not be encrypted
#subj to autosubmit informations
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out /etc/ssl/rfouraul.42.fr.crt \
		-keyout /etc/ssl/rfouraul.42.fr.key \
		-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=rfouraul/CN=rfouraul/"

#nginx config
COPY ./conf/nginx.conf /etc/nginx/conf.d

#mandatory
EXPOSE 443

#g flag for global directives
#daemon off tells nginx to stay in the foreground -> one container = one process
CMD ["usr/sbin/nginx", "-g", "daemon off;"]
