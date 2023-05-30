FROM debian:buster

RUN apt-get update && apt-get install -y redis-server \
        && rm -rf /var/lib/apt/lists/*

#COPY redis.conf /etc/redis/redis.conf
COPY ./tools/create_redis.sh /tmp/create_redis.sh

EXPOSE 6379

CMD ["sh", "/tmp/create_redis.sh"]
