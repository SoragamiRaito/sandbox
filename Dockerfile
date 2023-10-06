# BaseImage : ubunutu:22.04
FROM ubuntu:22.04

# update and install packages
RUN apt update && apt -y upgrade

# add user and
#RUN useradd -m sandbox && echo "sandbox:password" | chpasswd && usermod -aG sudo sandbox

# using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]
