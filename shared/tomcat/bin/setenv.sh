##### This file will be called from catalina.sh #####

# Starting tomcat 8.5, by default the files created by tomcat doesn’t grant read access to “others”, this includes log files.
# Override Tomcat's default UMASK of 0027 (rw-r-----) with 0022 (-rw-r--r--).
export UMASK="0022"

# JARs added to $CATALINA_HOME/lib (and other paths supported by the Common class loader) are available for use by Tomcat.
# However, tomcat-juli.jar (which contains Tomcat's enhancements to java.util.logging) is loaded by the System class 
# loader, not the Common class loader. Refer https://tomcat.apache.org/tomcat-9.0-doc/class-loader-howto.html for more details.
#
# As azure.appservice.jar contains formatters that tomcat-juli.jar needs to see, azure.appservice.jar needs to be added to
# a path supported by the System class loader, not the Common class loader. This implies that we need to make all dependencies
# of azure.appservice.jar available to System class loader as well.
#
# To make jars available to System class loader, they need to be added to CLASSPATH in setenv.sh (this file).
# Update the CLASSPATH to load the AzMon formatter jar and its dependency servlet-api.jar.
CLASSPATH=$CATALINA_BASE/lib/servlet-api.jar:$CATALINA_BASE/lib/azure.appservice.jar
