# BaseImage : ubunutu:22.04
FROM ubuntu:22.04

# update and install packages
RUN apt update && apt upgrade

# using "sleep infinity" for container persistence
CMD [ "sleep", "infinity" ]
