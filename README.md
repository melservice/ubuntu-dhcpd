# Das Image ubuntu-dhcpd

Dies sind die Quellen für einen DHCP-Service auf Ubuntu-Basis

## Organisation der Daten im Image

Die benötigten Dateien werden in zwei Kategorien eingeteilt. Die Eingangsdateien werden benötigt, damit der Container arbeiten kann. Die Ausgangsdateien werden vom Dienst geschrieben und müssen nach Beendigung des Containers erhalten bleiben.

## Skripte

Der im Container laufende Dienst wird über ein Skript hochgefahren und auch beendet. Das Skript kopiert die Eingangsdateien aus dem Eingangsvolume an den korrekten Platz für den DHCP-Service. Die vom Service geschriebenen Dateien - die Verwaltung der Leases - werden beim Beenden in das Ausgabeverzeichnis kopiert.