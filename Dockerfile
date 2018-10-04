FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends isc-dhcp-server \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY dhcpd.conf /etc/dhcp/dhcpd.conf

RUN touch /var/lib/dhcp/dhcpd.leases

#VOLUME ["/etc/dhcpd/dhcpd.conf"]

EXPOSE 67/udp

#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dhcpd"]
