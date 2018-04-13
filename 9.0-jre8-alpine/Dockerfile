FROM tomcat:9-jre8-alpine
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

RUN rm -r /usr/local/tomcat/webapps/

COPY init_container.sh /bin/init_container.sh
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY web.xml /tmp/tomcat/web.xml
COPY catalina.properties /usr/local/tomcat/conf/catalina.properties
COPY context.xml /usr/local/tomcat/conf/context.xml
COPY logging.properties /usr/local/tomcat/conf/logging.properties
COPY index.jsp /tmp/webapps/ROOT/index.jsp
COPY background.png /tmp/webapps/ROOT/background.png
COPY sshd_config /etc/ssh/
COPY tmp/shared/app_insights/AI-Agent.xml /usr/local/app_insights/aiagent/
COPY tmp/shared/app_insights/ApplicationInsights.xml /usr/local/app_insights/tomcat_lib/

ENV CATALINA_OPTS -javaagent:/usr/local/app_insights/aiagent/applicationinsights-agent-2.0.2.jar $CATALINA_OPTS

ENV JAVA_OPTS -Djdk.tls.ephemeralDHKeySize=2048 $JAVA_OPTS
ENV JAVA_OPTS -Djava.protocol.handler.pkgs=org.apache.catalina.webresources $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager $JAVA_OPTS
ENV JAVA_OPTS -Dsite.logdir=/home/LogFiles $JAVA_OPTS
ENV JAVA_OPTS -Dsite.home=/home $JAVA_OPTS
ENV JAVA_OPTS -Dsite.tempdir=/tmp $JAVA_OPTS
ENV JAVA_OPTS -Dport.http=80 $JAVA_OPTS
ENV _JAVA_OPTIONS -Djava.net.preferIPv4Stack=true

RUN apk add --update openssh-server \
        && echo "root:Docker!" | chpasswd \
        && apk update && apk add openrc \
        && rm -rf /var/cache/apk/* \
        && wget -O /usr/local/app_insights/tomcat_lib/applicationinsights-core-2.0.2.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/2.0.2/applicationinsights-core-2.0.2.jar --no-verbose \
        && wget -O /usr/local/app_insights/tomcat_lib/applicationinsights-web-2.0.2.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/2.0.2/applicationinsights-web-2.0.2.jar --no-verbose \
        && wget -O /usr/local/app_insights/aiagent/applicationinsights-agent-2.0.2.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/2.0.2/applicationinsights-agent-2.0.2.jar --no-verbose \
        && chmod 755 /bin/init_container.sh 

EXPOSE 80 2222

ENTRYPOINT ["/bin/init_container.sh"]
