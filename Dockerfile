FROM ubuntu:22.04

ARG PASSWORD
ENV PASSWORD=${PASSWORD}
WORKDIR /home/soragami

RUN apt update && apt upgrade
RUN useradd -m soragami && echo "soragami:{PASSWORD}" | chpasswd

WORKDIR /home/soragami

COPY ./files /home/soragami/

USER soragami

CMD [ "sleep", "infinity" ]
