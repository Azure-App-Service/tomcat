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

echo "Setup openrc ..." && openrc && touch /run/openrc/softlevel

echo Starting ssh service...
rc-service sshd start

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

# Temporary workaround until wardeploy supports clean deployment.
# This creates a hardcoded deployment manifest for the files in the /home/site/wwwroot/webapps/ROOT directory.
if [ ! -f /home/site/deployments/active ]
then
    FIRST_DEPLOYMENT_ID=c9b8ca0c06d240138b32705530b4bf37
    mkdir -p /home/site/deployments/$FIRST_DEPLOYMENT_ID
    echo index.jsp > /home/site/deployments/$FIRST_DEPLOYMENT_ID/manifest
    echo background.png >> /home/site/deployments/$FIRST_DEPLOYMENT_ID/manifest
    # NOTE: Using echo -n because it is important that there be no new line at the end of the deployment ID
    echo -n $FIRST_DEPLOYMENT_ID > /home/site/deployments/active
    echo "first manifest created."
else
    echo "skipped creating the first manifest."
fi

# WEBSITE_INSTANCE_ID will be defined uniquely for each worker instance while running in Azure.
# During development it may not be defined, in that case  we set WEBSITE_INSTNACE_ID=dev.
if [ -z "$WEBSITE_INSTANCE_ID" ]
then
    export WEBSITE_INSTANCE_ID=dev
fi

# BEGIN: Configure App Insights

# Inject App Insights artefcats into Tomcat, if APPINSIGHTS_INSTRUMENTATIONKEY is defined
if [[ -v APPINSIGHTS_INSTRUMENTATIONKEY ]]
then
    echo "Initializing App Insights.."
    mv /usr/local/app_insights/tomcat_lib/* /usr/local/tomcat/lib/
    mv /tmp/tomcat/web.xml /usr/local/tomcat/conf/web.xml
else
    echo "Skipping App Insights initialization"
fi

# END: Configure App Insights

export JAVA_OPTS="$JAVA_OPTS -Dcatalina.instance.name=$WEBSITE_INSTANCE_ID"

echo Listing environment variables being passed to Tomcat...
printenv
echo Finished listing environment variables being passed to Tomcat.

# Start Tomcat
echo Starting Tomcat with CATALINA_BASE set to \"$CATALINA_BASE\"
catalina.sh run
