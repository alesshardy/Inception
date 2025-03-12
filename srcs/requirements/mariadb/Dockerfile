# base image
FROM debian:bullseye

# update and upgrade system and install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server 

# copy file from host to container
COPY ./conf/mdb-conf.sh /mdb-conf.sh

# permission to file
RUN chmod +x /mdb-conf.sh

# command to run when containers start
ENTRYPOINT [ "./mdb-conf.sh" ]