# BaseImage : ubunutu:22.04
FROM ubuntu:22.04

# update and install packages
RUN apt update
RUN apt install -y git && apt install sudo

# add user and 
RUN useradd -m sandbox && echo "sandbox:password" | chpasswd && usermod -aG sudo sandbox 

# copy files
COPY ./files/ /home/sandbox/

# using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]