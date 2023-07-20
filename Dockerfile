# BaseImage : ubunutu:22.04
FROM ubuntu:22.04

# apdate and add user
RUN apt update && apt upgrade
RUN useradd -m -p soragami soragami

# copy files
COPY ./files/ /home/soragami/

# using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]