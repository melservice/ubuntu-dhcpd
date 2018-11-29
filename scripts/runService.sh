#!/bin/bash
#
# Start des Services

pidfile="/var/run/dhcpd.pid";

# ----------------------------------------------------------------------------------------------

function stopService {
	if [ -f "$pidfile" ]; then
		kill -15 $(cat "$pidfile");
	fi;
	
	# Die vergebenen Leases retten
	cp -p /var/lib/dhcp/dhcpd.leases /docker/output;
	
	return 0;
}

# ----------------------------------------------------------------------------------------------

# per Trap wird der Dienst wieder heruntergefahren
trap 'stopService; exit $?' EXIT SIGINT SIGKILL SIGTERM

# Die alten Output-Dateien wiederherstellen
if [ -f /docker/output/dhcpd.leases ]; then
	cp -p /docker/utput/dhcpd.leases /var/lib/dhcp/;
fi;

# Die neuen Eingabedatei aufbereiten
if [ -f /docker/inut/dhcpd.conf ]; then
	cp -p /docker/inut/dhcpd.conf /etc/dhcp/dhcpd.conf;
	
	# Das Subnetz im Docker-Container muss in der Konfiguration hinzugefügt werden
	echo '
	
	subnet 172.17.0.0 netmask 255.255.255.0 {
	        option subnet-mask 255.255.255.0;
	        option routers 10.1.3.2;
	        option domain-name "home.melsaesser.de";
	
	        # DNS aktualisieren
	        ddns-domainname "home.melsaesser.de";
	
	        pool {
	                deny known-clients;
	
	                range 172.17.0.100 172.17.0.200;
	        }
	}' >> /etc/dhcp/dhcpd.conf
fi;

# Der DHCP-Dämon wird gestartet
/usr/sbin/dhcpd

# Auf das Beenden des DHCP-Daemons warten
sleep 100;
if [ -f "$pidfile" ]; then
	waitPID=$(cat "$pidfile");
	while ps aux | grep "$pidfile" 2>/dev/null >/dev/null; do
		echo sleep 1;
		sleep 1;
	done;
else
	echo "PID-File '$pidfile' ist nicht vorhanden";
fi;
