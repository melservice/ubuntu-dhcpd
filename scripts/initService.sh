#!/bin/bash
#
# Initialisierung des Service beim Erstellen des Images

apt-get install -y --no-install-recommends isc-dhcp-server

touch /var/lib/dhcp/dhcpd.leases
