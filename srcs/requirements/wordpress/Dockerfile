FROM debian:bullseye

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl \
                        php \
                        php7.4-fpm \
                        php-mysql \
                        mariadb-client 

# a verif pk copy diff de mariadb
COPY ./conf/wp-conf.sh /

RUN chmod +x wp-conf.sh

ENTRYPOINT ["./wp-conf.sh"]