FROM debian:bullseye

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl \
                        php \
                        php7.4-fpm \
                        php-mysql \
                        mariadb-client 

COPY ./conf/wp-conf.sh /

RUN chmod +x wp-conf.sh

ENTRYPOINT ["./wp-conf.sh"]