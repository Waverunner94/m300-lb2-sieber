## Docker-Umgebung in Cloud (K3/K4/K6)  
Mithilfe von [AWS](https://aws.amazon.com/) EC2 (Amazon Elastic Compute Cloud) habe ich Docker auf einer Amazon Linux 2 Maschine installiert und die Container von dieser Maschine aus ausgeführt.  
1. Erstellen eines AWS-Accounts, dies ermöglicht eine kostenlose 12-Monatige Nutzung verschiedener AWS-Dienstleistungen (Kreditkarte benötigt!).  
2. Erzeugen einer *AWS EC2 Instance*, hier habe ich mich für die kostenfreie Amazon Linux 2 Instanz entschieden.  
3. SSH-Key herunterladen und mit PuTTYgen einen privaten Key erzeugen um eine [SSH-Verbindung via PuTTy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console) zu ermöglichen.  
4. Mithilfe den vorhandenen Informationen der erzeugten AWS EC2 Insanz, eine SSH-Verbindung via PuTTy zur Amazon Linux 2 Maschine herstellen.  
5. Updaten der Linux Instanz mit *sudo yum update -y*  

### Docker Installation  
1. Docker installieren mit *sudo amazon-linux-extras install docker*
2. Docker starten mit *sudo service docker start*  
3. Den ec2-user (User der Amazon Linux 2 Instanz) zur Docker-Gruppe hinzufügen um Docker-Befehle ohne sudo ausführen zu können *sudo usermod -a -G docker ec2-user*  
4.  Nach aus- und einloggen mit *docker info* prüfen ob Docker Befehle nun ohne sudo ausgeführt werden können.    
5.  Mit *sudo su* als Root-User anmelden und mit *cd /var/lib/docker/* das Verzeichnis wechseln.  
6.  Die Berechtigungen für das Verzeichnis *Volumes* mit *sudo chmod -R 755 volumes/* ändern.  

### Docker Compose Installation  
1. Mit *sudo -i* als Root-User anmelden  
2. Das docker-compose Paket mit folgendem Script herunterladen: *curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose*  
3. Die Ausführungsberechtigungen setzen mit *chmod +x /usr/local/bin/docker-compose*  
4. Root-User abmelden mit *exit*  
5. Prüfen ob docker-compose korrekt installiert wurde mit *docker-compose -v*  

### Wordrpess-Einrichtung mithilfe von Compose  
1. Ein neues Verzeichnis erstellen und direkt in dieses Wechseln mit *mkdir ~/wordpress_app && cd ~/wordpress_app*  
2. Mit beliebigem Texteditor ein neues Dockerfile erzeugen, ich habe dafür den vim-Editor gewählt: *sudo vim Dockerfile*  
3. Folgende Zeilen in das File einfügen. Diese geben Docker an wie das Image gebuildet werden muss:  
´´´
    FROM orchardup/php5  
    ADD . /code  
´´´
4. Das File speichern und den Editor verlassen. Ein neues File namens *docker-compose.yml* mit *sudo vim docker-compose.yml* erzeugen.  
5. Folgende Zeilen in das File einfügen:
´´´
    wordpress:
    image: wordpress
    links:
     - mariadb:mysql
    environment:
     - WORDPRESS_DB_PASSWORD=<password>
    ports:
     - "18.195.215.14:80:80"
    volumes:
     - ./code:/code
     - ./html:/var/www/html
mariadb:
    image: mariadb
    environment:
     - MYSQL_ROOT_PASSWORD=<password>
     - MYSQL_DATABASE=wordpress
    volumes:
     - ./database:/var/lib/mysql
´´´
In diesem File werden die Befehle für Docker Compose festgelegt. Es soll ein Wordpress und ein MariaDB Container mit den jeweiligen Konfigurationen erstellt werden.  
6. Das File speichern und den Editor beenden. Mit *docker-compose up -d* werden die Container aufgrund des .yml-Files erzeugt.  
7. Die Amazon Linux 2 Instanz via Browser abrufen: *[http://18.195.215.14:80](http://18.195.215.14/)*