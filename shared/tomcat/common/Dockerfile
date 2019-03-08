ARG BASE_IMAGE=__PLACEHOLDER_BASEIMAGE__
FROM $BASE_IMAGE

LABEL maintainer="Azure App Services Container Images <appsvc-images@microsoft.com>"

ENV AI_VERSION __PLACEHOLDER_AI_VERSION__
ENV TOMCAT_VERSION __PLACEHOLDER_TOMCAT_VERSION__
ENV TOMCAT_MAJOR __PLACEHOLDER_TOMCAT_MAJOR__

ENV PORT 80
ENV SSH_PORT 2222

ENV PATH /usr/local/tomcat/bin:$PATH

# Remove the sample webapps provided by Tomcat
RUN rm -rf /usr/local/tomcat/webapps/

# Remove the artifacts created by the base Java image, as we know we don't need them
RUN rm -rf /tmp/webapps/

COPY init_container.sh /bin/init_container.sh
COPY web-easyauth-ai.xml /tmp/tomcat/conf/web-easyauth-ai.xml
COPY index.jsp /tmp/tomcat/webapps/ROOT/index.jsp
COPY background.png /tmp/tomcat/webapps/ROOT/background.png
COPY sshd_config /etc/ssh/
COPY tmp/shared/app_insights/AI-Agent.xml /usr/local/app_insights/aiagent/
COPY tmp/shared/app_insights/ApplicationInsights.xml /usr/local/app_insights/tomcat_lib/

RUN apk add --update openssh-server bash openrc \
        && rm -rf /var/cache/apk/* \
        && echo "root:Docker!" | chpasswd \
        && wget -O /tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz --no-verbose \
        && tar xvzf /tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz -C /tmp \
        && mv /tmp/apache-tomcat-$TOMCAT_VERSION /usr/local/tomcat \
        && rm -rf /usr/local/tomcat/webapps \
        && rm -f /tmp/apache-tomcat-$TOMCAT_VERSION.tar.gz \
        && wget -O /usr/local/app_insights/tomcat_lib/applicationinsights-core-$AI_VERSION.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/$AI_VERSION/applicationinsights-core-$AI_VERSION.jar --no-verbose \
        && wget -O /usr/local/app_insights/tomcat_lib/applicationinsights-web-$AI_VERSION.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/$AI_VERSION/applicationinsights-web-$AI_VERSION.jar --no-verbose \
        && wget -O /usr/local/app_insights/aiagent/applicationinsights-agent-$AI_VERSION.jar https://github.com/Microsoft/ApplicationInsights-Java/releases/download/$AI_VERSION/applicationinsights-agent-$AI_VERSION.jar --no-verbose \
        && chmod 755 /bin/init_container.sh 

COPY server.xml /usr/local/tomcat/conf/server.xml
COPY catalina.properties /usr/local/tomcat/conf/catalina.properties
COPY context.xml /usr/local/tomcat/conf/context.xml
COPY logging.properties /usr/local/tomcat/conf/logging.properties
COPY web-easyauth.xml /usr/local/tomcat/conf/web.xml
COPY tmp/shared/easyauth/azure.appservice.easyauth.jar /usr/local/tomcat/lib/
COPY tmp/shared/appservice/azure.appservice.jar /usr/local/tomcat/lib/
COPY tmp/shared/tomcat/bin/setenv.sh /usr/local/tomcat/bin/

EXPOSE 80 2222

ENTRYPOINT ["/bin/init_container.sh"]
