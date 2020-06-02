FROM ubuntu:18.04
 
ARG token
ARG osSelection=2
ARG port=513
ARG tz=Europe/Berlin



RUN export DEBIAN_FRONTEND=noninteractive

#

# Identify the maintainer of an image
LABEL maintainer="xilef.remmos@gmx.de"

RUN apt-get update && apt-get upgrade -y

#install tzdata package
RUN apt-get install -y tzdata
# set your timezone
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install wget -y

RUN wget --content-disposition https://gosbot.de/install && chmod 777 gosbot_installer.sh && ./gosbot_installer.sh "${token}" "${osSelection}" "${port}"

RUN gosbot start

EXPOSE port # todo
