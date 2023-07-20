# BaseImage : ubunutu:22.04
FROM ubuntu:22.04

# set workdir
WORKDIR /home/soragami/

# add user
RUN useradd -m -p soragami soragami

# update and install packages
RUN apt update && apt upgrade
RUN apt install -y git && apt autoremove

# copy files
COPY ./files/ /home/soragami/

# using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]