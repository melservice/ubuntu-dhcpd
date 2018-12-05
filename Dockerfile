FROM ubuntu:18.04

LABEL version="1.0"
LABEL description="DHCP-Server als Service auf Ubuntu-Basis"
LABEL maintainer="develop@melsaesser.de"

# Verzeichnis für die Initialisierung des Images sowie Input und Output erstellen
RUN mkdir -p /docker/init \
	&& mkdir -p /docker/input \
	&& mkdir -p /docker/output

# Skripte für initialisierung des Images und Start des Containers kopieren
COPY scripts/initService.sh /docker/init/initService.sh
COPY scripts/runService.sh /docker/init/runService.sh

# Die aktuellen Paketlisten laden, Updates holen und Initialisierung laufen lassen,
# danach wird wieder aufgeräumt
RUN touch /dev/null \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends apt-utils \
	&& /docker/init/initService.sh \
	&& apt-get -y full-upgrade \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Volumes, die nach außen gereicht werden sollen
VOLUME ["/docker/input", "/docker/output"]

# Port, der nach aussen durchgereicht wird
EXPOSE 67/udp

# Dies ist das Start-Kommando
CMD ["/docker/init/runService.sh"]
