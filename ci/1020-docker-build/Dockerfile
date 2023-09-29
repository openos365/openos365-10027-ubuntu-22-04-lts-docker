FROM ubuntu:22.04

# 1
COPY files/ /tmp/files/

# 2
USER root
WORKDIR /root
ENV USER=root
ENV HOME=/root
ENV METEOR_ALLOW_SUPERUSER=true
RUN /tmp/files/install.sh

# 3
RUN rm -rf /tmp/files/
