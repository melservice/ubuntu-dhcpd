#!/bin/bash
#
# Das Skript erstellt das Docker-Image
# ###########################################################################

# Sicherheitshalber
. ~/.profile

# Aktuelles Verzeichnis merken und auf das Verzeichnis des Skriptes umschalten
oldPWD=$(pwd);
cd $(dirname $0);

DOCKER_NAME="melservice/ubuntu-dhcpd";

# Das Image bauen
docker build --no-cache -t $DOCKER_NAME:latest .;
rc=$?;

# Bei Erfolg wird das Image bei Docker-Hub hochgeladen
if [ $rc -eq 0 ]; then
	docker push $DOCKER_NAME:latest
fi;
