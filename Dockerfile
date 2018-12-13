FROM melservice/ubuntu-server:latest

LABEL version="1.0" \
	description="DHCP-Server als Service auf Ubuntu-Basis" \
	maintainer="develop@melsaesser.de"

# Skripte für initialisierung des Images und Start des Containers kopieren
ADD scripts /docker/init/

# Die aktuellen Paketlisten laden, Updates holen und Initialisierung laufen lassen,
# danach wird wieder aufgeräumt
RUN /docker/init/initService.sh

# Volumes, die nach außen gereicht werden sollen
VOLUME ["/docker/input", "/docker/output"]

# Port, der nach aussen durchgereicht wird
EXPOSE 67/udp

# Dies ist das Start-Kommando
CMD ["bash", "/docker/init/runService.sh"]
