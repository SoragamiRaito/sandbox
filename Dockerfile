# BaseImage : ubunutu:22.04
FROM ubuntu:22.04

# Update and install packages
RUN apt update && apt -y upgrade

# Create a user with matching UID and GID of the host user
ARG USER_ID
ARG GROUP_ID
RUN groupadd -g ${GROUP_ID} sandbox && useradd -u ${USER_ID} -g ${GROUP_ID} -m sandbox && echo "sandbox:password" | chpasswd && usermod -aG sudo sandbox

# Using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]
