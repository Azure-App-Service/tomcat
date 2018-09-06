ARG BASE_IMAGE=appsvc/java:8-jre8_0000000000
FROM $BASE_IMAGE
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

ENV AI_VERSION 2.1.0
ENV TOMCAT_VERSION 9.0.11
ENV TOMCAT_MAJOR 9

ENV JAVA_OPTS -Djdk.tls.ephemeralDHKeySize=2048 $JAVA_OPTS
ENV JAVA_OPTS -Djava.protocol.handler.pkgs=org.apache.catalina.webresources $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties $JAVA_OPTS
ENV JAVA_OPTS -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager $JAVA_OPTS
ENV JAVA_OPTS -Dsite.logdir=/home/LogFiles $JAVA_OPTS
ENV JAVA_OPTS -Dsite.home=/home $JAVA_OPTS
ENV JAVA_OPTS -Dsite.tempdir=/tmp $JAVA_OPTS
ENV JAVA_OPTS -Dport.http=80 $JAVA_OPTS
ENV _JAVA_OPTIONS -Djava.net.preferIPv4Stack=true

ENV PATH /usr/local/tomcat/bin:$PATH

RUN rm -rf /usr/local/tomcat/webapps/

COPY init_container.sh /bin/init_container.sh
COPY web.xml /tmp/tomcat/web.xml
COPY index.jsp /tmp/webapps/ROOT/index.jsp
COPY background.png /tmp/webapps/ROOT/background.png
COPY sshd_config /etc/ssh/
COPY tmp/shared/app_insights/AI-Agent.xml /usr/local/app_insights/aiagent/
COPY tmp/shared/app_insights/ApplicationInsights.xml /usr/local/app_insights/tomcat_lib/

RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog openssh-server wget \
        && rm -rf /var/lib/apt/lists/* \
        && echo "root:Docker!" | chpasswd \
        && wget -O /tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz http://www-eu.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz --no-verbose \
        && tar xvzf /tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz -C /tmp \
        && mv /tmp/apache-tomcat-$TOMCAT_VERSION /usr/local/tomcat \
        && rm -rf /usr/local/tomcat/webapps \
        && rm -f /tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz \
        && wget -O /usr/local/app_insights/tomcat_lib/applicationinsights-core-$AI_VERSION.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/v$AI_VERSION/applicationinsights-core-$AI_VERSION.jar --no-verbose \
        && wget -O /usr/local/app_insights/tomcat_lib/applicationinsights-web-$AI_VERSION.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/v$AI_VERSION/applicationinsights-web-$AI_VERSION.jar --no-verbose \
        && wget -O /usr/local/app_insights/aiagent/applicationinsights-agent-$AI_VERSION.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/v$AI_VERSION/applicationinsights-agent-$AI_VERSION.jar --no-verbose \
        && chmod 755 /bin/init_container.sh 

COPY server.xml /usr/local/tomcat/conf/server.xml
COPY catalina.properties /usr/local/tomcat/conf/catalina.properties
COPY context.xml /usr/local/tomcat/conf/context.xml
COPY logging.properties /usr/local/tomcat/conf/logging.properties

EXPOSE 80 2222

ENTRYPOINT ["/bin/init_container.sh"]
