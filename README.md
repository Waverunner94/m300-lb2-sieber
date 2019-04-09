# Modul 300 – LB2

## Inhaltsverzeichnis
- [Modul 300 – LB2](#modul-300-%E2%80%93-lb2)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [01 - Verwendete Tools](#01---verwendete-tools)
  - [02 - Wissenstand](#02---wissenstand)
    - [02.1 - Linux](#021---linux)
    - [02.2 - Virtualisierung](#022---virtualisierung)
    - [02.3 - Vagrant](#023---vagrant)
    - [02.4 - Versionsverwaltung](#024---versionsverwaltung)
    - [02.5 - Mark Down](#025---mark-down)
    - [02.6 - Systemsicherheit](#026---systemsicherheit)
    - [02.7 - Containerisierung](#027---containerisierung)
    - [02.8 - Docker Desktop](#028---docker-desktop)
    - [02.9 - Microservices](#029---microservices)
  - [03 Lernschritte und Durchführung LB2](#03-lernschritte-und-durchf%C3%BChrung-lb2)


## 01 - Verwendete Tools
* Hyper-V
* Docker Desktop
* Visual Studio Code
* Git-Client (inkl. SSH-Key)
  
## 02 - Wissenstand

### 02.1 - Linux
Linux Grundkenntnisse sind vorhanden, war jedoch nie meine primäre Arbeitsumgebung.

### 02.2 - Virtualisierung
Erfahrung mit VMWare Workstation Player sowie VirtualBox.

### 02.3 - Vagrant
Vorkenntnisse aus Modul 300 - LB1, virtuelle Umgebung bestehend aus Proxy-, Web- und Datenbankserver mit Vagrantfile erzeugt.  

### 02.4 - Versionsverwaltung
Cloud-spezifische Erfahrung mit Versionverwaltung vorhanden: Dokumente in Google Drive jeweils so versionisiert, dass alte Versionen jederzeit wiederhergestellt werden konnten.
Keine Vorkenntnisse mit Git vorhanden.

### 02.5 - Mark Down
Vorkenntnisse aus Modul 300 - LB1 vorhanden, Dokumentation mit Mark Down geschrieben und auf GitHub Repository veröffentlicht.

### 02.6 - Systemsicherheit
Erfahrung mit der sicheren Aufbewahrung von sensitiven Daten, sicheres lagern von Passwörtern, Firewall, etc.  

### 02.7 - Containerisierung
Bisher keine Erfahrung mit Containerisierung gesammelt, noch nie damit gearbeitet oder mich damit auseinandergesetzt  

### 02.8 - Docker Desktop
Keine Vorkenntnisse mit Docker vorhanden, noch nie damit gearbeitet.  

### 02.9 - Microservices
Keine Vorkenntnisse mit Microservices vorhanden, noch nie damit auseinandergesetzt, bzw. gearbeitet.  

## 03 Lernschritte und Durchführung LB2
Die Lernschritte, die ich während der Durchführung von LB2 kontinuierlich aktualisieren werde.  

**Netzwerkplan**  


**Docker-Befehle**  
*docker ps -all*                                                - Zeigt alle aktiven und beendeten Container an.  
*docker images -a*                                              - Zeigt alle lokalen Images an.  
*docker rm [Containername]*                                     - Löscht beliebigen Container.  
*docker rmi [Imagename]*                                        - Löscht beliebiges Image.  
*docker pull [Filename]*                                        - Beliebiges Image herunterladen, z.B. Ubuntu.  
*docker volume create [name]*                                   - Erstellen eines Volumes auf dem Host.  
*docker inspect [volumename]*                                   - Zeigt detailierte Informationen zum erstellen Volume an.  
*docker run -it -volume1:/container/volume1 ubuntu /bin/bash*   - Startet Container mit interaktiven Shell und dem Volume.  
*docker build -t sali-welt .*                                   - Erstellt ein Image aufgrund des Dockerfiles im aktiven Verzeichnis und benennt dies "Sali-Welt".  

**Erstellen eines Images mit einem Dockerfile**  
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

**Ausführen eines Containers mit persistenter Datenablage**  
Damit ich den Container nicht bei jeder Änderung im PHP-File stoppen und wieder starten muss, erzeuge ich beim starten des Containers eine persistente Datenablage und jede Änderung die ich am Host im PHP-File vornehme wird auch im Container vorgenommen.  
1. In der CMD folgenden Befehl eingeben: *docker run -p 80:80 -v C:/lb2/src/:/var/www/html sali-welt*.  

Nun kann in einem beliebigen Browser mit der Eingabe *localhost* das index.php-File aufrufen und alle Änderungen auf dem Host sind sofort nach aktualisieren der Seite sichtbar.  

2. Mit der Tastenkombination *CTRL-C* in der CMD kann man den Container stoppen. 
3. Möchte ich den Container erneut starten, lasse ich mir mit *docker ps --all* alle vorhandenen Container anzeigen und starte diesen wieder indem ich die ersten paar Buchstaben und Ziffern der ID eintippe *docker start abc77*  