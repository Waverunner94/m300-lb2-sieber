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
* Oracle VirtualBox 6.0
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
