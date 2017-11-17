FROM tomcat:8.5-jre8
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>
RUN mkdir -p "/local/Temp"
RUN rm -r /usr/local/tomcat/webapps/
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY logging.properties /usr/local/tomcat/conf/logging.properties
COPY index.jsp /home/site/wwwroot/webapps/ROOT/index.jsp
COPY background.png /home/site/wwwroot/webapps/ROOT/background.png
ENV JAVA_OPTS -Djdk.tls.ephemeralDHKeySize=2048 $JAVA_OPTS
ENV JAVA_OPTS -Djava.protocol.handler.pkgs=org.apache.catalina.webresources $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager $JAVA_OPTS
ENV JAVA_OPTS -Dsite.logdir=/home/LogFiles/ $JAVA_OPTS
ENV JAVA_OPTS -Dsite.home=/home $JAVA_OPTS
ENV JAVA_OPTS -Dsite.tempdir=/local/Temp $JAVA_OPTS
ENV JAVA_OPTS -Dport.http=80 $JAVA_OPTS
ENV JAVA_OPTS -Djava.net.preferIPv4Stack=true $JAVA_OPTS
EXPOSE 80
CMD ["catalina.sh", "run"]