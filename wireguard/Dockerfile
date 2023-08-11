#
# Configuration From https://www.digitalocean.com/community/tutorials/how-to-set-up-wireguard-on-debian-11
#
FROM breizhland/base:debian11

ARG BUILD_DATE="08-11-2023"
ARG VERSION="v1"
LABEL build_version="Breizhland.eu version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="PsychoMonkey"

ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/root" \
  LANGUAGE="en_US.UTF-8" \
  LANG="en_US.UTF-8" \
  TERM="xterm"
RUN \
  echo "**** install apt-utils and locales ****" && \
  apt-get update && \
  apt-get install -y \
    apt-utils \
    locales && \
  echo "**** Configure sysctl.conf ****" && \
  echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    curl \
    gnupg \
    jq \
    netcat-traditional \
    tzdata \
    wireguard \
    wireguard-tools \
    systemd \
    systemd-sysv \
    iproute2 && \
	echo "**** cleanup ****" && \
	apt-get -y autoremove && \
	apt-get clean && \
	rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /var/log/* \
    /usr/share/man

RUN \
  echo "**** Enable the Wireguard Service ****" && \
	systemctl enable wg-quick@wg0.service

# ports and volumes
EXPOSE 51820/udp

VOLUME /etc/wireguard

ENTRYPOINT ["/sbin/init"]