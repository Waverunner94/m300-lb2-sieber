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
* PuTTy
  
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
```
+-----------------------------------------------------------+
! Container wordpress Frontend Webserver - 18.195.215.14:80 !
! Container mariadb Datenbank - Keine Public-IP             !
+-----------------------------------------------------------+
! Docker                                                    !
+-----------------------------------------------------------+
! Kubernetes Umgebung AWS EC2 Amazon Linux 2                !
+-----------------------------------------------------------+
! Notebook - Schulnetz 10.x.x.x                             !
+-----------------------------------------------------------+
```

**Übersicht Docker-Befehle**  
*docker ps -all*                                                - Zeigt alle aktiven und beendeten Container an.  
*docker images -a*                                              - Zeigt alle lokalen Images an.  
*docker rm [Containername]*                                     - Löscht beliebigen Container.  
*docker rmi [Imagename]*                                        - Löscht beliebiges Image.  
*docker pull [Filename]*                                        - Beliebiges Image herunterladen, z.B. Ubuntu.  
*docker volume create [name]*                                   - Erstellen eines Volumes auf dem Host.  
*docker inspect [volumename]*                                   - Zeigt detailierte Informationen zum erstellen Volume an.   
*docker build -t sali-welt .*                                   - Erstellt ein Image aufgrund des Dockerfiles im aktiven Verzeichnis und benennt dies "Sali-Welt".  

**Ausgeführte Projekte**
* [Lokales Setup](Lokales_Setup.md)

**Docker-Umgebung in Cloud (K3/K4/K6)**  
Mithilfe von [AWS](https://aws.amazon.com/) EC2 (Amazon Elastic Compute Cloud) habe ich Docker auf einer Amazon Linux 2 Maschine installiert und die Container von dieser Maschine aus ausgeführt.  
1. Erstellen eines AWS-Accounts, dies ermöglicht eine kostenlose 12-Monatige Nutzung verschiedener AWS-Dienstleistungen (Kreditkarte benötigt!).  
2. Erzeugen einer *AWS EC2 Instance*, hier habe ich mich für die kostenfreie Amazon Linux 2 Instanz entschieden.  
3. SSH-Key herunterladen und mit PuTTYgen einen privaten Key erzeugen um eine [SSH-Verbindung via PuTTy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console) zu ermöglichen.  
4. Mithilfe den vorhandenen Informationen der erzeugten AWS EC2 Insanz, eine SSH-Verbindung via PuTTy zur Amazon Linux 2 Maschine herstellen.  
5. Updaten der Linux Instanz mit *sudo yum update -y*  
6. Docker installieren mit *sudo amazon-linux-extras install docker*
7. Docker starten mit *sudo service docker start*  
8. Den ec2-user (User der Amazon Linux 2 Instanz) zur Docker-Gruppe hinzufügen um Docker-Befehle ohne sudo ausführen zu können *sudo usermod -a -G docker ec2-user*  
9. Nach aus- und einloggen mit *docker info* prüfen ob Docker Befehle nun ohne sudo ausgeführt werden können.  
10. Mit *docker volume create lb2* ein neues Volume-Verzeichnis erstellen.  
11. Mit *sudo su* als Root-User anmelden und mit *cd /var/lib/docker/* das Verzeichnis wechseln.  
12. Die Berechtigungen für das Verzeichnis *Volumes* mit *sudo chmod -R 755 volumes/* ändern.  
13. Ins Verzeichnis *Volumes* wechseln und mit *touch index.php* ein PHP-File erstellen.  
14. Mithilfe des VIM-Editors *vim index.php* das PHP-File bearbeiten und folgende Zeilen einfügen:  
```
  <?php
    echo "Sali welt"
  ?>
```
15. In ein beliebiges Verzeichnis wechseln und mit *touch Dockerfile* ein Dockerfile erstellen.  
16. Mithilfe des VIM-Editors *vim Dockerfile* das Dockerfile bearbeiten und folgende Zeilen einfügen:  
```
  FROM php:7.3.4-apache
  COPY src/ /var/www/html
  EXPOSE 80
```  
17. Ein neues Image basierend auf dem erstellten Dockerfile mit *docker build -t sali-welt .* erzeugen.  
18. Den Container mit der persistenten Dateiablage starten: *docker run -p 80:80 -v /var/lib/docker/volumes/lb2/:/var/www/html/ sali-welt*  
19. Die Amazon Linux 2 Instanz via Browser abrufen: *[http://18.195.215.14:80](http://18.195.215.14/)*