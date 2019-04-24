########################################################
### ***DO NOT EDIT*** This is an auto-generated file ###
########################################################
ARG BASE_IMAGE=mcr.microsoft.com/java/jre-headless:8u212-zulu-alpine-with-tools
ARG GIT_COMMIT=unspecified
FROM $BASE_IMAGE

# Re-define ARG to make the build argument available for use in the rest of the Dockerfile
ARG GIT_COMMIT

LABEL maintainer="Azure App Services Container Images <appsvc-images@microsoft.com>"

ENV AI_VERSION 2.1.2
ENV TOMCAT_VERSION 9.0.17
ENV TOMCAT_MAJOR 9
ENV GIT_COMMIT $GIT_COMMIT
ENV APPINSIGHTS_ENABLED 1

ENV PORT 80
ENV SSH_PORT 2222

ENV PATH /usr/local/tomcat/bin:$PATH

# Remove the sample webapps provided by Tomcat
RUN rm -rf /usr/local/tomcat/webapps/

# Remove the artifacts created by the base Java image, as we know we don't need them
RUN rm -rf /tmp/webapps/

COPY tmp/shared/tomcat/common/init_container.sh /bin/init_container.sh
COPY tmp/shared/tomcat/9.0/web-appservice-ai.xml /tmp/tomcat/conf/web-appservice-ai.xml
COPY tmp/shared/tomcat/common/index.jsp /tmp/tomcat/webapps/ROOT/index.jsp
COPY tmp/shared/tomcat/common/background.png /tmp/tomcat/webapps/ROOT/background.png
COPY tmp/shared/tomcat/common/sshd_config /etc/ssh/
COPY tmp/shared/app_insights/AI-Agent.xml /usr/local/app_insights/aiagent/
COPY tmp/shared/app_insights/ApplicationInsights.xml /usr/local/app_insights/tomcat_lib/

RUN apk add --update openssh-server bash openrc \
        && rm -rf /var/cache/apk/* \
        # Remove unnecessary services
        && rm -f /etc/init.d/hwdrivers \
                 /etc/init.d/hwclock \
                 /etc/init.d/mtab \
                 /etc/init.d/bootmisc \
                 /etc/init.d/modules \
                 /etc/init.d/modules-load \
                 /etc/init.d/modloop \
        # Can't do cgroups
        && sed -i 's/\tcgroup_add_service/\t#cgroup_add_service/g' /lib/rc/sh/openrc-run.sh \
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

COPY tmp/shared/tomcat/9.0/server.xml /usr/local/tomcat/conf/server.xml
COPY tmp/shared/tomcat/9.0/catalina.properties /usr/local/tomcat/conf/catalina.properties
COPY tmp/shared/tomcat/9.0/context.xml /usr/local/tomcat/conf/context.xml
COPY tmp/shared/tomcat/9.0/logging.properties /usr/local/tomcat/conf/logging.properties
COPY tmp/shared/tomcat/9.0/web-appservice.xml /usr/local/tomcat/conf/web.xml
COPY tmp/shared/easyauth/azure.appservice.easyauth.jar /usr/local/tomcat/lib/
COPY tmp/shared/appservice/azure.appservice.jar /usr/local/tomcat/lib/
COPY tmp/shared/tomcat/bin/setenv.sh /usr/local/tomcat/bin/

EXPOSE 80 2222

ENTRYPOINT ["/bin/init_container.sh"]
########################################################
### ***DO NOT EDIT*** This is an auto-generated file ###
########################################################

