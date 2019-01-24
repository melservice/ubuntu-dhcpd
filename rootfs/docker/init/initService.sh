#!/bin/bash
#
# Initialisierung des Service beim Erstellen des Images

/docker/init/aptInstall.sh isc-dhcp-server

touch /var/lib/dhcp/dhcpd.leases
