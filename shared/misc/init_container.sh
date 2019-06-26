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

**NOTE**: No files or system changes outside of /home will persist beyond your application's current session. /home is your application's persistent storage and is shared across all the server instances.


EOL
cat /etc/motd

echo "Setup openrc ..." && openrc && touch /run/openrc/softlevel

echo Updating /etc/ssh/sshd_config to use PORT $SSH_PORT
sed -i "s/SSH_PORT/$SSH_PORT/g" /etc/ssh/sshd_config

echo Starting ssh service...
rc-service sshd start

# Enable case-insensitive string matching
shopt -s nocasematch

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

# If no app is published at /home/site/wwwroot/webapps, use the parking page app.
# If an app is published, the default behavior is to copy the app to a local location, unless:
# 1. WEBSITE_SKIP_LOCAL_COPY is defined to 1 or TRUE, OR,
# 2. Local cache is enabled, in which case making a local copy again is unnecessary.
if [ ! -d /home/site/wwwroot/webapps ]
then
    SITEROOT=/tmp/tomcat/webapps
    echo "Using parking page app with SITEROOT=$SITEROOT"
elif [[ "$WEBSITE_LOCAL_CACHE_OPTION" = "Always" || "$WEBSITE_SKIP_LOCAL_COPY" = "1"  || "$WEBSITE_SKIP_LOCAL_COPY" = "true" ]]
then
    SITEROOT=/home/site/wwwroot/webapps
    echo "No local copy needed. SITEROOT=$SITEROOT"
else
    SITEROOT=/usr/local/tomcat/webapps
    cp -r /home/site/wwwroot/webapps $SITEROOT
    echo "Made a local copy of the app and using SITEROOT=$SITEROOT"
fi

# COMPUTERNAME will be defined uniquely for each worker instance while running in Azure.
# If COMPUTERNAME isn't available, we assume that the container is running in a dev environment.
# If running in dev environment, define required environment variables.
if [ -z "$COMPUTERNAME" ]
then
    export COMPUTERNAME=dev

    # BEGIN: AzMon related environment variables
    export HTTP_LOGGING_ENABLED=1
    export WEBSITE_HOSTNAME=dev.appservice.com
    export APPSETTING_WEBSITE_AZMON_ENABLED=True
    export DIAGNOSTIC_LOGS_MOUNT_PATH=/var/log/diagnosticLogs
    # END: AzMon related environment variables
fi

# BEGIN: Configure App Insights

# Inject App Insights artefcats into Tomcat, if APPINSIGHTS_INSTRUMENTATIONKEY is set to a non-empty value
if [[ ! -z $APPINSIGHTS_INSTRUMENTATIONKEY && "$APPINSIGHTS_ENABLED" == "1" ]]
then
    echo "Initializing App Insights.."
    export CATALINA_OPTS="-javaagent:/usr/local/app_insights/aiagent/applicationinsights-agent-$AI_VERSION.jar $CATALINA_OPTS"
    mv /usr/local/app_insights/tomcat_lib/* /usr/local/tomcat/lib/
    mv /tmp/tomcat/conf/web-appservice-ai.xml /usr/local/tomcat/conf/web.xml
else
    echo "Skipping App Insights initialization"
fi

# END: Configure App Insights

# BEGIN: Define JAVA OPTIONS

# Configure JAVA OPTIONS. Make sure, we append the default values instead of prepending them.
# That way, the default values take precedence and we avoid the risk of an appsetting overriding the critical (default) properties.

export JAVA_OPTS="$JAVA_OPTS -Djdk.tls.ephemeralDHKeySize=2048"
export JAVA_OPTS="$JAVA_OPTS -Djava.protocol.handler.pkgs=org.apache.catalina.webresources"
export JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties"
export JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"
export JAVA_OPTS="$JAVA_OPTS -Dsite.logdir=/home/LogFiles"
export JAVA_OPTS="$JAVA_OPTS -Dsite.azMonlogdir=$DIAGNOSTIC_LOGS_MOUNT_PATH"
export JAVA_OPTS="$JAVA_OPTS -Dsite.root=$SITEROOT"
export JAVA_OPTS="$JAVA_OPTS -Dsite.tempdir=/tmp"
export JAVA_OPTS="$JAVA_OPTS -Dport.http=$PORT"
export JAVA_OPTS="$JAVA_OPTS -noverify"
export JAVA_OPTS="$JAVA_OPTS -Dcatalina.instance.name=$COMPUTERNAME"

export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Djava.net.preferIPv4Stack=true"

# END: Define JAVA OPTIONS

# BEGIN: Configure /etc/profile

eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

# We want all ssh sesions to start in the /home directory
echo "cd /home" >> /etc/profile

# END: Configure /etc/profile

# BEGIN: Process startup file / startup command, if any

DEFAULT_STARTUP_FILE=/home/startup.sh
STARTUP_FILE=
STARTUP_COMMAND=

# The web app can be configured to run a custom startup command or a custom startup script
# This custom command / script will be available to us as a param ($1, $2, ...)
#
# IF $1 is a non-empty string AND an existing file, we treat $1 as a startup file (and ignore $2, $3, ...)
# IF $1 is a non-empty string BUT NOT an existing file, we treat $@ (equivalent of $1, $2, ... combined) as a startup command
# IF $1 is an empty string AND $DEFAULT_STARTUP_FILE exists, we use it as the startup file
# ELSE, we skip running the startup script / command
#
if [ -n "$1" ] # $1 is a non-empty string
then
    if [ -f "$1" ] # $1 file exists
    then
        STARTUP_FILE=$1
    else
        STARTUP_COMMAND=$@
    fi
elif [ -f $DEFAULT_STARTUP_FILE ] # Default startup file path exists
then
    STARTUP_FILE=$DEFAULT_STARTUP_FILE
fi

echo STARTUP_FILE=$STARTUP_FILE
echo STARTUP_COMMAND=$STARTUP_COMMAND

# If $STARTUP_FILE is a non-empty string, we need to run the startup file
# We first fix the EOL characters in it and then run it
if [ -n "$STARTUP_FILE" ]
then

    # Copy startup file to a temporary location and fix the EOL characters in the temp file (to avoid changing the original copy)
    TMP_STARTUP_FILE=/tmp/startup.sh
    echo Copying $STARTUP_FILE to $TMP_STARTUP_FILE and fixing EOL characters in $TMP_STARTUP_FILE
    cp $STARTUP_FILE $TMP_STARTUP_FILE
    dos2unix $TMP_STARTUP_FILE
    
    echo Running STARTUP_FILE: $TMP_STARTUP_FILE
    source $TMP_STARTUP_FILE
    echo Finished running startup file $TMP_STARTUP_FILE
else
    echo No STARTUP_FILE available.
fi

if [ -n "$STARTUP_COMMAND" ]
then
    echo Running STARTUP_COMMAND: "$STARTUP_COMMAND"
    $STARTUP_COMMAND
else
    echo No STARTUP_COMMAND defined.
fi

# END: Process startup file / startup command, if any

# Start Tomcat
echo Starting Tomcat with CATALINA_BASE set to \"$CATALINA_BASE\"
catalina.sh run
