# BaseImage : ubuntu:22.04
FROM ubuntu:22.04

# Update and install packages
RUN apt update && apt -y upgrade

# Install necessary tools
RUN apt install -y sudo curl

# Create a user with matching UID and GID of the host user
# Set a password for the user
# Add the user to the sudo group
# Change the login shell to bash
ARG USER_ID
ARG GROUP_ID
RUN groupadd -g ${GROUP_ID} sandbox && useradd -u ${USER_ID} -g ${GROUP_ID} -m sandbox && \
    echo "sandbox:password" | chpasswd && \
    usermod -aG sudo sandbox && \
    chsh -s /bin/bash sandbox

# Allow sudo without password for the user
RUN echo "sandbox ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install Visual Studio Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# setting default user
USER sandbox

# Using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]
