FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends isc-dhcp-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 67/udp

#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dhcpd"]
