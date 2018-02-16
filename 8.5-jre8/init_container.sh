#!/usr/bin/env bash
cat >/etc/motd <<EOL 
  _____                               
  /  _  \ __________ _________   ____  
 /  /_\  \\___   /  |  \_  __ \_/ __ \ 
/    |    \/    /|  |  /|  | \/\  ___/ 
\____|__  /_____ \____/ |__|    \___  >
        \/      \/                  \/ 
A P P   S E R V I C E   O N   L I N U X

Documentation: http://aka.ms/webapp-linux
EOL
cat /etc/motd

echo Listing environment variables passed to init_container.sh...
printenv
echo Finished listing environment variables passed to init_container.sh.

echo Starting ssh service...
service ssh start

# If a custom initialization script is defined, run it and exit.
if [ -n "$INIT_SCRIPT" ]
then
    echo Running custom initialization script
    source $INIT_SCRIPT
    echo Finished running custom initialization script. Exiting.
    exit
fi

# Default to CATALINA_BASE=/home/tomcat
if [[ -z $CATALINA_BASE && -a /home/tomcat/conf/server.xml ]]
then
    export CATALINA_BASE=/home/tomcat
fi

# if IGNORE_CATALINA_BASE=1 or true, unset CATALINA_BASE
if [[ "$IGNORE_CATALINA_BASE" = "1" ||  "$IGNORE_CATALINA_BASE" = "true" ]]
then
    echo Setting CATALINA_BASE to empty as IGNORE_CATALINA_BASE is set to $IGNORE_CATALINA_BASE
    export CATALINA_BASE=
fi

if [ ! -d /home/site/wwwroot/webapps ]
then
    mkdir -p /home/site/wwwroot
    cp -r /tmp/webapps /home/site/wwwroot
fi

# WEBSITE_INSTANCE_ID will be defined uniquely for each worker instance while running in Azure.
# During development it may not be defined, in that case  we set WEBSITE_INSTNACE_ID=dev.
if [ -z "$WEBSITE_INSTANCE_ID" ]
then
    export WEBSITE_INSTANCE_ID=dev
fi

export JAVA_OPTS="$JAVA_OPTS -Dcatalina.instance.name=$WEBSITE_INSTANCE_ID"

echo Listing environment variables being passed to Tomcat...
printenv
echo Finished listing environment variables being passed to Tomcat.

# Start Tomcat
echo Starting Tomcat with CATALINA_BASE set to \"$CATALINA_BASE\"
catalina.sh run
