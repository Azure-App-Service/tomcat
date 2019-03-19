##### This file will be called from catalina.sh #####

# Starting tomcat 8.5, by default the files created by tomcat doesn’t grant read access to “others”, this includes log files.
# Override Tomcat's default UMASK of 0027 (rw-r-----) with 0022 (-rw-r--r--).
export UMASK="0022"

# Any changes to JUL needs to be loaded at system level. https://tomcat.apache.org/tomcat-9.0-doc/class-loader-howto.html
# Loading the Az-Mon formatter
CLASSPATH=$CATALINA_BASE/lib/servlet-api.jar:$CATALINA_BASE/lib/azure.appservice.jar