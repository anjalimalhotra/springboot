#!/bin/bash
sudo service anup-routing stop

# create anup-routing service
cat > /etc/init/anup-routing.conf <<'EOF'

description "anup Routing Server"

  start on runlevel [2345]
  stop on runlevel [!2345]
  respawn
  respawn limit 10 5

  # run as non privileged user 
  # add user with this command:
  ## adduser --system --ingroup www-data --home /opt/apache-tomcat apache-tomcat
  # Ubuntu 12.04: (use 'exec sudo -u apache-tomcat' when using 10.04)
  setuid ubuntu
  setgid ubuntu

  # adapt paths:
  exec java  -jar /home/ubuntu/deploy/spring-boot-web-0.0.1-SNAPSHOT.jar  >> /home/ubuntu/logs/routing.log 2>&1

  # cleanup temp directory after stop
  post-stop script
    #rm -rf $CATALINA_HOME/temp/*
  end script
EOF

# remove old directory
rm -rf /home/ubuntu/deploy

# create directory deploy
mkdir -p /home/ubuntu/deploy 


