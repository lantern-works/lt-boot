from stephank/archlinux:armv6-base


# copy saved pacman database
COPY pre/pkg/ /var/lib/pacman/sync/


# system setup
RUN mkdir -p /tmp/install
COPY src/install/*.sh /tmp/install/
RUN /tmp/install/hardware.sh
RUN /tmp/install/software.sh


# platform install
COPY src/platform /platform
WORKDIR /platform/


# install app
ARG CACHEBUST=1
ENTRYPOINT /bin/bash