#!/bin/bash
sudo apt-get update 
sudo apt-get install default-jdk -y
sudo service anup-routing stop

# create anup-routing service
cat > /etc/systemd/system/anup-routing.service <<'EOF'
[Unit]
Description=My Webapp Java REST Service
After=network.target

[Service]
Type=forking
User=root
#path to executable. 
#executable is a bash script which calls jar file
ExecStart=/home/ubuntu/deploy/anup-routing.sh
ExecStop=/home/ubuntu/deploy/anup-routing.sh

SuccessExitStatus=143
TimeoutStopSec=10
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target

EOF


# remove old directory
rm -rf /home/ubuntu/deploy

# create directory deploy
mkdir -p /home/ubuntu/deploy 
mkdir -p /home/ubuntu/deploy/logs
cat > /home/ubuntu/deploy/anup-routing.sh <<'EOF'
#!/bin/sh
sudo /usr/bin/java -jar /home/ubuntu/deploy/spring-boot-web-0.0.1-SNAPSHOT.jar  >> /home/ubuntu/deploy/logs/routing.log 2>&1

EOF

chmod 775 /home/ubuntu/deploy/anup-routing.sh 
