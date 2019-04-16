## Erstellen eines Images mit einem Dockerfile (K3)  
1. Zuerst habe ich ein Verzeichnis (*C:/LB2/src*) erstellt.  
2. Mithilfe Visual Studio Code habe ich ein *index.php* File in */src/* erzeugt und ein Dockerfile direkt in *C:/LB2/*.  
3. Das PHP-File besteht aus einem simplen Code:  
```
  <?php
    echo "Sali welt"
  ?>
```
4. Um den PHP-Apache Dienst auf Docker laufen zu lassen, suche ich auf der Docker Hub Webseite nach dem offiziellen PHP Image. Folgendes kommt nun ins Dockerfile:  
```
  FROM php:7.3.4-apache
  COPY src/ /var/www/html
  EXPOSE 80
```  
FROM: gibt an welches Image heruntergeladen werden soll, in diesem Fall PHP-Apache 7.3.4.  
COPY: Kopiert den Inhalt des Host-Verzeichnisses (*src/*) ins Verzeichnis des Containers (*/var/www/html*).  
EXPOSE: Sagt Docker auf welche Ports die laufenden Container hören sollen.  
5. Das Dockerfile abspeichern und via CMD den Befehl *docker build -t sali-welt .* eingeben + ausführen. Dies erstellt ein neues Image mit dem Namen *Sali-Welt*.  

### Ausführen eines Containers mit persistenter Datenablage (K3)  
Damit ich den Container nicht bei jeder Änderung im PHP-File stoppen und wieder starten muss, erzeuge ich beim starten des Containers eine persistente Datenablage und jede Änderung die ich am Host im PHP-File vornehme wird auch im Container vorgenommen.  
1. In der CMD folgenden Befehl eingeben: *docker run -p 80:80 -v C:/lb2/src/:/var/www/html/ sali-welt*.  

Nun kann man in einem beliebigen Browser mit der Eingabe *localhost* das index.php-File aufrufen und alle Änderungen auf dem Host sind sofort nach aktualisieren der Seite sichtbar.  

2. Mit der Tastenkombination *CTRL-C* in der CMD kann man den Container stoppen. 
3. Möchte ich den Container erneut starten, lasse ich mir mit *docker ps --all* alle vorhandenen Container anzeigen und starte diesen wieder indem ich die ersten paar Buchstaben und Ziffern der ID eintippe *docker start abc77*  