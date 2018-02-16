FROM tomcat:8.5-jre8-alpine
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

RUN rm -r /usr/local/tomcat/webapps/

COPY init_container.sh /bin/init_container.sh
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY logging.properties /usr/local/tomcat/conf/logging.properties
COPY index.jsp /tmp/webapps/ROOT/index.jsp
COPY background.png /tmp/webapps/ROOT/background.png
COPY sshd_config /etc/ssh/

ENV JAVA_OPTS -Djdk.tls.ephemeralDHKeySize=2048 $JAVA_OPTS
ENV JAVA_OPTS -Djava.protocol.handler.pkgs=org.apache.catalina.webresources $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager $JAVA_OPTS
ENV JAVA_OPTS -Dsite.logdir=/home/LogFiles/Application $JAVA_OPTS
ENV JAVA_OPTS -Dsite.home=/home $JAVA_OPTS
ENV JAVA_OPTS -Dsite.tempdir=/tmp $JAVA_OPTS
ENV JAVA_OPTS -Dport.http=80 $JAVA_OPTS
ENV _JAVA_OPTIONS -Djava.net.preferIPv4Stack=true

RUN apk add --update openssh-server \
        && echo "root:Docker!" | chpasswd \
        && apk update && apk add openrc \
        && rm -rf /var/cache/apk/* \
        && chmod 755 /bin/init_container.sh 

EXPOSE 80 2222

ENTRYPOINT ["/bin/init_container.sh"]
