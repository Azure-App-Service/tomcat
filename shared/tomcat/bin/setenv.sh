# Any changes to JUL needs to be loaded at system level. https://tomcat.apache.org/tomcat-9.0-doc/class-loader-howto.html
# tThis file will be called from catalina.sh
CLASSPATH=$CATALINA_BASE/lib/servlet-api.jar:$CATALINA_BASE/lib/azure.appservice.jar